import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bottomnavgator_screen/categories.dart';
import 'package:shopapp/bottomnavgator_screen/favorites.dart';
import 'package:shopapp/bottomnavgator_screen/settings.dart';
import 'package:shopapp/bottomnavgator_screen/shophome.dart';
import 'package:shopapp/models/catgors_model.dart';
import 'package:shopapp/models/favoritesmodel.dart';
import 'package:shopapp/models/favorithomemodel.dart';
import 'package:shopapp/models/searchmodel.dart';
import 'package:shopapp/models/shophomemodel.dart';
import 'package:shopapp/models/shoploginmodels.dart';
import 'package:shopapp/shared/dio_helper.dart';
import 'package:shopapp/shared/endpoint.dart';
import 'package:shopapp/shared/stayle/constans.dart';
import 'package:shopapp/shop_cubit/shopstate.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopinitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  var currantIndex = 0;
  List<Widget> bottomScreen = [
    ShopHome(),
    ShopCatgories(),
    ShopFavorites(),
    ShopSettings()
  ];
  void changeBottomScreen(int index) {
    currantIndex = index;
    emit(ShopChangeBottomState());
  }

  ShopHome_Model? homeModel;
  Map<int, bool> favorites = {};
  void getHomeModel() {
    emit(ShopHomeLoadDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = ShopHome_Model.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.infavorites!});
      });
      // print(homeModel!.status);
      // print(homeModel!.data!.banners[0].image);
      print("get Data Success");
      emit(
        ShopHomeSuccessDataState(),
      );
    }).catchError((error) {
      print("get Data Error");
      emit(
        ShopHomeErrorDataState(error.toString()),
      );
    });
  }

  CategoresModel? categoresModel;
  void getcategoresModel() {
    emit(ShopHomeLoadDataState());
    DioHelper.getData(url: CATEGORES, token: token).then((value) {
      categoresModel = CategoresModel.fromJson(value.data);

      print("get Catgores Success");
      emit(
        ShopCatgoresSuccessState(),
      );
    }).catchError((error) {
      print("get Catgores Error");
      emit(
        ShopCatgoresErrorState(error.toString()),
      );
    });
  }

  FavoritesModel? chanageFavoritesModel;
  void changeFavorites(int prodectid) {
    favorites[prodectid] = !favorites[prodectid]!;
    emit(ShopFavoriteschangeState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': prodectid}, token: token)
        .then((value) {
      chanageFavoritesModel = FavoritesModel.fromJson(value.data);
      print(chanageFavoritesModel!.message);
      if (!(categoresModel!.status!)) {
        favorites[prodectid] = !favorites[prodectid]!;
      } else {
        favoritesGetModel();
      }
      emit(ShopFavoritesSuccessState(chanageFavoritesModel!));
    }).catchError((error) {
      emit(ShopFavoritesErrorState(error.toString()));
    });
  }

  FavoritesHomeModel? favoritGetModel;
  void favoritesGetModel() {
    emit(ShopGetLoadedFavoritesSuccessState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritGetModel = FavoritesHomeModel.fromJson(value.data);

      print("get Favorites Success");
      emit(
        ShopGetFavoritesSuccessState(),
      );
    }).catchError((error) {
      print("get Favorites Error");
      emit(
        ShopGetFavoritesErrorState(error.toString()),
      );
    });
  }

  ShopLoginModels? GetUserModel;
  void GetUserModels() {
    emit(ShopGetLoadedUserSuccessState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      GetUserModel = ShopLoginModels.fromJson(value.data);

      print("get User Success");
      emit(
        ShopGetUserSuccessState(GetUserModel!),
      );
    }).catchError((error) {
      print("get User Error");
      emit(
        ShopGetUserErrorState(error.toString()),
      );
    });
  }

  ShopLoginModels? updateUserModel;
  void updateUserModels({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateLoadedUserSuccessState());
    DioHelper.putData(url: UPDAE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      GetUserModel = ShopLoginModels.fromJson(value.data);

      print("Update User Success");
      emit(
        ShopUpdateUserSuccessState(GetUserModel!),
      );
    }).catchError((error) {
      print("Update User Error");
      emit(
        ShopUpdateUserErrorState(error.toString()),
      );
    });
  }

  SeaechModel? model;
  void searchModel(String text) {
    emit(LoadingSearchState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      model = SeaechModel.fromJson(value.data);
      print('Search Done');
      emit(SuccessSearchState());
    }).catchError((error) {
      print('Search have Problem');
      print(error.toString());
      emit(ErrorSearchState(error.toString()));
    });
  }
}
