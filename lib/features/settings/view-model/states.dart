abstract class ProfileStates {}

class InitialProfileState extends ProfileStates {}

class GetUserDataLoadingState extends ProfileStates {}

class GetUserDataSuccessState extends ProfileStates {}

class GetUserDataErrorState extends ProfileStates {
  final String error;
  GetUserDataErrorState(this.error);
}

class GetProfileImageLoadingState extends ProfileStates {}

class GetProfileImageErrorState extends ProfileStates {}

class GetProfileImageSuccessState extends ProfileStates {}

class UploadProfileImageLoadingState extends ProfileStates {}

class UploadProfileImageSuccessState extends ProfileStates {}

class UploadProfileImageErrorState extends ProfileStates {
  final String error;
  UploadProfileImageErrorState(this.error);
}

class UpdateUserProfileLoadingState extends ProfileStates {}

class UpdateUserProfileSuccessState extends ProfileStates {}

class UpdateUserProfileErrorState extends ProfileStates {
  final String error;
  UpdateUserProfileErrorState(this.error);
}
