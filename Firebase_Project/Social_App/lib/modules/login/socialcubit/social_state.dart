abstract class SocialLoginState {}

class LoginInitialState extends SocialLoginState {}

class LoginLoadingState extends SocialLoginState {}

class LoginSuccessState extends SocialLoginState {
  final String uId;
  LoginSuccessState(
    this.uId,
  );
}

class LoginErrorState extends SocialLoginState {
  final String error;

  LoginErrorState(this.error);
}

class RegisterLoadingState extends SocialLoginState {}

class RegisterSuccessState extends SocialLoginState {}

class RegisterErrorState extends SocialLoginState {
  final String error;

  RegisterErrorState(this.error);
}

class LoginChangeState extends SocialLoginState {}

class CreatUserLoadingState extends SocialLoginState {}

class CreatUserSuccessState extends SocialLoginState {}

class CreatUserErrorState extends SocialLoginState {
  final String error;

  CreatUserErrorState(this.error);
}
