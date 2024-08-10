import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/network/firebase-constants.dart';
import 'package:movie/features/auth/presentation/view-model/otp/otp-states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit() : super(OtpInitState());

  static OtpCubit get(context) => BlocProvider.of(context);

  static String verifyId = '';

  Future<void> phoneOtp({
    required String phoneNumber,
  }) async {
    emit(OtpLoadingState());

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
      );
    } catch (e) {
      emit(OtpErrorState('An error occurred during phone verification.'));
    }
  }

  void _verificationCompleted(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(OtpVerificationCompletedState());
    } catch (e) {
      emit(OtpVerificationFailedState(
          'Verification completed, but an error occurred.'));
    }
  }

  void _verificationFailed(FirebaseAuthException e) {
    emit(OtpVerificationFailedState(e.message ?? 'Verification failed.'));
  }

  void _codeSent(String verificationId, int? resendToken) {
    verifyId = verificationId;
    emit(OtpCodeSentState());
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    verifyId = verificationId;
    emit(OtpCodeAutoRetrievalTimeoutState());
  }

  Future<void> loginWithOtp({required String otp}) async {
    emit(OtpLoadingState());

    final cred = PhoneAuthProvider.credential(
      verificationId: verifyId,
      smsCode: otp,
    );

    try {
      final user = await FirebaseAuth.instance.signInWithCredential(cred);
      if (user.user != null) {
        FirebaseConstants.phoneNumber = user.user!.phoneNumber!;
        emit(OtpLoginSuccessState());
       
      } else {
        emit(OtpOtpLoginFailedState('Error during OTP login.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(OtpOtpLoginFailedState(e.message ?? 'OTP login failed.'));
    } catch (e) {
      emit(OtpErrorState(e.toString()));
    }
  }
}
