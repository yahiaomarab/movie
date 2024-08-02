// ignore: file_names
abstract class OtpStates {}

class OtpInitState extends OtpStates {}

class OtpLoadingState extends OtpStates {}

class OtpCodeSentState extends OtpStates {}

class OtpVerificationCompletedState extends OtpStates {}

class OtpVerificationFailedState extends OtpStates {
  final String error;

  OtpVerificationFailedState(this.error);
}

class OtpCodeAutoRetrievalTimeoutState extends OtpStates {}

class OtpLoginSuccessState extends OtpStates {}

class OtpOtpLoginFailedState extends OtpStates {
  final String error;

  OtpOtpLoginFailedState(this.error);
}

class OtpErrorState extends OtpStates {
  final String error;

  OtpErrorState(this.error);
}
