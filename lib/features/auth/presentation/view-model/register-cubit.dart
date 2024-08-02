import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/auth/presentation/view-model/register-state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  static String verifyId = '';

  Future<void> phoneRegister({
    required String phoneNumber,
  }) async {
    emit(RegisterLoadingState());

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
      emit(RegisterErrorState('An error occurred during phone verification.'));
    }
  }

  void _verificationCompleted(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(RegisterVerificationCompletedState());
    } catch (e) {
      emit(RegisterVerificationFailedState(
          'Verification completed, but an error occurred.'));
    }
  }

  void _verificationFailed(FirebaseAuthException e) {
    emit(RegisterVerificationFailedState(e.message ?? 'Verification failed.'));
  }

  void _codeSent(String verificationId, int? resendToken) {
    verifyId = verificationId;
    emit(RegisterCodeSentState());
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    verifyId = verificationId;
    emit(RegisterCodeAutoRetrievalTimeoutState());
  }

  Future<void> loginWithOtp({required String otp}) async {
  emit(RegisterLoadingState());


  final cred = PhoneAuthProvider.credential(
    verificationId: verifyId,
    smsCode: otp,
  );

  try {
    final user = await FirebaseAuth.instance.signInWithCredential(cred);
    if (user.user != null) {
      emit(RegisterOtpLoginSuccessState());
    } else {
      emit(RegisterOtpLoginFailedState('Error during OTP login.'));
    }
  } on FirebaseAuthException catch (e) {
    emit(RegisterOtpLoginFailedState(e.message ?? 'OTP login failed.'));
  } catch (e) {
    emit(RegisterErrorState(e.toString()));
  }
}

}
