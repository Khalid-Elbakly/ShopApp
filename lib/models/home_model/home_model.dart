import 'dart:convert';

class HomeModel{
  String? status;
  HomeModelDataModel? data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeModelDataModel.fromJson(json['data']);
  }
}

class HomeModelDataModel{
  BannersModel? banners;
  ProductsModel? products;
  String? image;
  HomeModelDataModel.fromJson(Map<String,dynamic> json){
    image = json['ad'];
    banners = BannersModel.fromJson(json['banners']);
    products = ProductsModel.fromJson(json['producs']);
  }
}

class BannersModel{
  int? id;
  String? image;

  BannersModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel{
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;

  ProductsModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}