import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/helper/cache-helper.dart';
import 'package:movie/core/network/firebase-constants.dart';
import 'package:movie/features/auth/presentation/view-model/login/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);

loginUser({
  required String email,
  required String password,
}) {
  emit(LoginLoadingState());
  
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((value) {
    emit(LoginSuccessState());
    FirebaseConstants.uid = value.user!.uid;
    CacheHelper.setUserToken(value.user!.uid);
    print(CacheHelper.getUserToken());
  }).catchError((error) {
    if (error is FirebaseAuthException) {
      // Use the FirebaseAuthException message if available
      emit(LoginErrorState(error.message ?? 'An unknown error occurred.'));
    } else {
      // Handle other errors
      emit(LoginErrorState(error.toString()));
    }
  });
}

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangingVisibility());
  }
}
