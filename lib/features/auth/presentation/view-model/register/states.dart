abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class CreateUserSuccessState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {
  final String error;
  CreateUserErrorState(this.error);
}

class RegisterUserLoadingState extends RegisterStates {}

class RegisterUserSuccessState extends RegisterStates {}

class RegisterUserErrorState extends RegisterStates {
  final String error;
  RegisterUserErrorState(this.error);
}


class ChangingVisibility extends RegisterStates{}