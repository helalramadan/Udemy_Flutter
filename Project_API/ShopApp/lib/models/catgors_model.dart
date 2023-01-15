class CategoresModel {
  bool? status;
  CatgoresData? data;
  CategoresModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CatgoresData.fromJson(json['data']);
  }
}

class CatgoresData {
  int? caruntPage;
  List<CatgoresDataList> data = [];
  CatgoresData.fromJson(Map<String, dynamic> json) {
    caruntPage = json['current_page'];
    json['data'].forEach((ele) {
      data.add(CatgoresDataList.fromJson(ele));
    });
  }
}

class CatgoresDataList {
  int? id;
  String? name;
  String? image;
  CatgoresDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
