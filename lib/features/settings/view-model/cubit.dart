import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseConstants.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error));
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
            image: downloadUrl);
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
