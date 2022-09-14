import 'package:shopapp/models/categories_model/categories_model.dart';

class CategoriesModel{
  bool? status;
  catogoriesData? data;

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = catogoriesData.fromJson(json['data']);
  }
}

class catogoriesData{
  List<dataModel> data = [];
  catogoriesData.fromJson(Map<String,dynamic> json){

    json['data'].forEach((element){
      data.add(dataModel.fromJson(element));
    });
  }
}

class dataModel{
  int? id;
  String? name;
  String? image;

  dataModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}