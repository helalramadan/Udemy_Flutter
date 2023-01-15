class ShopHome_Model {
  bool? status;
  DataModel? data;
  ShopHome_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<BannersModels> banners = [];
  List<ProductsModels> products = [];
  DataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((ele) {
      banners.add(BannersModels.fromJson(ele));
    });
    json['products'].forEach((ele) {
      products.add(ProductsModels.fromJson(ele));
    });
  }
}

class BannersModels {
  int? id;
  String? image;
  bool? category;
  bool? product;
  BannersModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}

class ProductsModels {
  int? id;
  dynamic price;
  dynamic oldprice;
  int? discount;
  String? image;
  String? name;
  bool? infavorites;
  bool? incart;
  ProductsModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    infavorites = json['in_favorites'];
    incart = json['in_cart'];
  }
}
