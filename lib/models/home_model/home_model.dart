import 'dart:convert';

import 'package:shopapp/models/home_model/home_model.dart';

class HomeModel{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel{
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  String? image;
  HomeDataModel.fromJson(Map<String,dynamic> json){

    json['banners'].forEach((element)
    {
      banners.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(ProductsModel.fromJson(element));
    });
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
  String? name;

  ProductsModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}