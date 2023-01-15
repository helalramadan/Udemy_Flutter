import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/business/business.dart';
import '../../modules/science/science.dart';
import '../../modules/settings/setting.dart';
import '../../modules/sports/sport.dart';
import '../../shared/networke/remote/dio_helper.dart';
import 'stats.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewInitiialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<BottomNavigationBarItem> bottomBarItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "science"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "settings"),
  ];
  List<Widget> screen = [
    const BusinessScreen(),
    const SportScreen(),
    ScienceScreen(),
    const SettingScreen(),
  ];

  void bottomSheet(int index) {
    currentindex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();

    emit(BottomSheetState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(BusinessLoadingState());
    if (business.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        "country": "eg",
        "category": "business",
        "apiKey": "9447a04eb9554abfb94382bdc444cf58"
      }).then((value) {
        business = value.data['articles'];
        print(business[0]['title']);
        emit(BusinessGetDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(BusinessGetDataErrorState(error.toString()));
      });
    } else {
      emit(BusinessGetDataSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(SportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "9447a04eb9554abfb94382bdc444cf58"
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(SportsGetDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SportsGetDataErrorState(error.toString()));
      });
    } else {
      emit(SportsGetDataSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(ScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        "country": "eg",
        "category": "science",
        "apiKey": "9447a04eb9554abfb94382bdc444cf58"
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(ScienceGetDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ScienceGetDataErrorState(error.toString()));
      });
    } else {
      emit(ScienceGetDataSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(value) {
    emit(SearchLoadingState());

    DioHelper.getData(url: 'v2/everything', query: {
      "q": "$value",
      "apiKey": "9447a04eb9554abfb94382bdc444cf58"
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(SearchGetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchGetDataErrorState(error.toString()));
    });
  }
}
