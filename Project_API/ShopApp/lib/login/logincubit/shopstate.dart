import 'package:shopapp/models/register_model.dart';
import 'package:shopapp/models/shoploginmodels.dart';

abstract class ShopeLoginState {}

class loginInitialState extends ShopeLoginState {}

class loginLoadingState extends ShopeLoginState {}

class loginSuccessState extends ShopeLoginState {
  final ShopLoginModels loginModel;

  loginSuccessState(this.loginModel);
}

class loginErrorState extends ShopeLoginState {
  final String error;

  loginErrorState(this.error);
}

class RegisterLoadingState extends ShopeLoginState {}

class RegisterSuccessState extends ShopeLoginState {
  final ShopRegisterModels registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends ShopeLoginState {
  final String error;

  RegisterErrorState(this.error);
}

class loginChangeState extends ShopeLoginState {}
