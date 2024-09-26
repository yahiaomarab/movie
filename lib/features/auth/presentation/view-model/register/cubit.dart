import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/network/firebase-constants.dart';
import 'package:movie/features/auth/data/models/user-model.dart';
import 'package:movie/features/auth/presentation/view-model/register/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  createUser({
    required String email,
    required String phoneNumber,
    required String name,
    required String uid,
  }) {
    UserModel model = UserModel(
        phone: phoneNumber,
        email: email,
        userName: name,
        uid: uid,
        image: 'https://cdn-icons-png.flaticon.com/512/149/149071.png');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error));
    });
  }

  void registerUser({
    required String email,
    required String name,
    required String password,
    required String confirmPassword,
  }) {
    emit(RegisterUserLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegisterUserSuccessState());
      createUser(
          email: email,
          phoneNumber: FirebaseConstants.phoneNumber,
          name: name,
          uid: value.user!.uid);
      FirebaseConstants.uid = value.user!.uid;
    }).catchError((error) {
      emit(RegisterUserErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangingVisibility());
  }
}
