class SeaechModel {
  bool? status;
  SearchData? data;
  SeaechModel.fromJson(Map<String, dynamic> json) {
    status = json['id'];
    data = SearchData.fromJson(json['data']);
  }
}

class SearchData {
  int? current_page;
  List<Data> data = [];
  SearchData.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((ele) {
      data.add(Data.fromJson(ele));
    });
  }
}

class Data {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  List<String> images = [];
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    json['images'].forEach((ele) {
      images.add(ele);
    });
  }
}
