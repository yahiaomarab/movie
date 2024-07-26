// ignore: file_names
abstract class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterCodeSentState extends RegisterStates {}

class RegisterVerificationCompletedState extends RegisterStates {}

class RegisterVerificationFailedState extends RegisterStates {
  final String error;

  RegisterVerificationFailedState(this.error);
}

class RegisterCodeAutoRetrievalTimeoutState extends RegisterStates {}

class RegisterOtpLoginSuccessState extends RegisterStates {}

class RegisterOtpLoginFailedState extends RegisterStates {
  final String error;

  RegisterOtpLoginFailedState(this.error);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}
