abstract class NewsState {}

class NewInitiialState extends NewsState {}

class BottomSheetState extends NewsState {}

class BusinessLoadingState extends NewsState {}

class BusinessGetDataSuccessState extends NewsState {}

class BusinessGetDataErrorState extends NewsState {
  late final error;

  BusinessGetDataErrorState(this.error);
}

class ScienceLoadingState extends NewsState {}

class ScienceGetDataSuccessState extends NewsState {}

class ScienceGetDataErrorState extends NewsState {
  late final error;

  ScienceGetDataErrorState(this.error);
}

class SportsLoadingState extends NewsState {}

class SportsGetDataSuccessState extends NewsState {}

class SportsGetDataErrorState extends NewsState {
  late final error;

  SportsGetDataErrorState(this.error);
}

class SearchLoadingState extends NewsState {}

class SearchGetDataSuccessState extends NewsState {}

class SearchGetDataErrorState extends NewsState {
  late final error;

  SearchGetDataErrorState(this.error);
}
