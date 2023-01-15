class FavoritesModel {
  bool? status;
  String? message;

  // FavoritesDataModel? data;
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
