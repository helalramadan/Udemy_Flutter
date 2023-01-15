import 'package:shopapp/models/favoritesmodel.dart';

import '../models/shoploginmodels.dart';

abstract class ShopState {}

class ShopinitialState extends ShopState {}

class ShopChangeBottomState extends ShopState {}

class ShopHomeLoadDataState extends ShopState {}

class ShopHomeSuccessDataState extends ShopState {}

class ShopHomeErrorDataState extends ShopState {
  final String error;

  ShopHomeErrorDataState(this.error);
}

class ShopCatgoresSuccessState extends ShopState {}

class ShopCatgoresErrorState extends ShopState {
  final String error;

  ShopCatgoresErrorState(this.error);
}

class ShopFavoriteschangeState extends ShopState {}

class ShopFavoritesSuccessState extends ShopState {
  final FavoritesModel model;

  ShopFavoritesSuccessState(this.model);
}

class ShopFavoritesErrorState extends ShopState {
  final String error;

  ShopFavoritesErrorState(this.error);
}

class ShopGetLoadedFavoritesSuccessState extends ShopState {}

class ShopGetFavoritesSuccessState extends ShopState {}

class ShopGetFavoritesErrorState extends ShopState {
  final String error;

  ShopGetFavoritesErrorState(this.error);
}

class ShopGetLoadedUserSuccessState extends ShopState {}

class ShopGetUserSuccessState extends ShopState {
  final ShopLoginModels userData;

  ShopGetUserSuccessState(this.userData);
}

class ShopGetUserErrorState extends ShopState {
  final String error;

  ShopGetUserErrorState(this.error);
}

class ShopUpdateLoadedUserSuccessState extends ShopState {}

class ShopUpdateUserSuccessState extends ShopState {
  final ShopLoginModels userData;

  ShopUpdateUserSuccessState(this.userData);
}

class ShopUpdateUserErrorState extends ShopState {
  final String error;

  ShopUpdateUserErrorState(this.error);
}

class InitialSearchState extends ShopState {}

class LoadingSearchState extends ShopState {}

class SuccessSearchState extends ShopState {}

class ErrorSearchState extends ShopState {
  final String error;

  ErrorSearchState(this.error);
}
