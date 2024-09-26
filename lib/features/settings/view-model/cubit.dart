import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie/core/network/firebase-constants.dart';
import 'package:movie/features/auth/data/models/user-model.dart';
import 'package:movie/features/settings/view-model/states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(InitialProfileState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  dynamic profileImage;
  var picker = ImagePicker();

  void getUserData() {
    String uid = FirebaseConstants.uid.isNotEmpty
        ? FirebaseConstants.uid
        : FirebaseAuth.instance.currentUser?.uid ?? '';

    if (uid.isEmpty) {
      emit(GetUserDataErrorState('User ID is not available'));
      return;
    }
    emit(GetUserDataLoadingState());
FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .get()
    .then((value) {
      if (value.exists) {
        userModel = UserModel.fromJson(value.data()!);
        emit(GetUserDataSuccessState());
      } else {
        emit(GetUserDataErrorState('User data not found'));
      }
    }).catchError((error) {
      emit(GetUserDataErrorState(
          (error as FirebaseException).message ?? 'Unknown error occurred'));
    });

  }

  Future<void> getProfileImage() async {
    emit(GetProfileImageLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetProfileImageSuccessState());
    } else {
      emit(GetProfileImageErrorState());
    }
  }

  void uploadProfileImage() {
    if (profileImage == null) {
      emit(UploadProfileImageErrorState('No image selected'));
      return;
    }

    emit(UploadProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((downloadUrl) {
        updateUserProfile(
          name: userModel!.userName,
          email: userModel!.email,
          phone: userModel!.phone,
          image: downloadUrl,
        );
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState(error));
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState(error));
    });
  }

  void updateUserProfile({
    required String name,
    required String email,
    required String phone,
    String? image,
  }) {
    if (userModel == null) {
      emit(UpdateUserProfileErrorState('User data is not available'));
      return;
    }

    // If the phone number is being updated, call the method to update it in Firebase Auth
    if (phone != userModel!.phone) {
      _updatePhoneNumberInAuth(phone).then((_) {
        // Proceed with updating Firestore after updating the phone number in Firebase Auth
        _updateUserInFirestore(
            name: name, email: email, phone: phone, image: image);
      }).catchError((error) {
        emit(UpdateUserProfileErrorState(error.toString()));
      });
    } else {
      // If phone number hasn't changed, directly update Firestore
      _updateUserInFirestore(
          name: name, email: email, phone: phone, image: image);
    }
  }

  Future<void> _updatePhoneNumberInAuth(String newPhoneNumber) async {
    emit(UpdateUserProfileLoadingState());

    // Re-authenticate the user using their current phone number
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: newPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          // Update the phone number in Firebase Auth after verification
          await FirebaseAuth.instance.currentUser
              ?.updatePhoneNumber(credential);
        } catch (error) {
          throw 'Failed to update phone number in Auth: $error';
        }
      },
      verificationFailed: (FirebaseAuthException error) {
        throw 'Phone verification failed: ${error.message}';
      },
      codeSent: (String verificationId, int? resendToken) {
        // Handle OTP sent event
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
      },
    );
  }

  void _updateUserInFirestore({
    required String name,
    required String email,
    required String phone,
    String? image,
  }) {
    emit(UpdateUserProfileLoadingState());

    UserModel user = UserModel(
        phone: phone,
        email: email,
        userName: name,
        uid: userModel!.uid,
        image: image ?? userModel!.image);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(user.toMap())
        .then((value) {
      emit(UpdateUserProfileSuccessState());
      getUserData(); // Refresh user data after update
    }).catchError((error) {
      emit(UpdateUserProfileErrorState(error));
    });
  }
}
