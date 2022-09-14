import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_states.dart';
import 'package:shopapp/models/categories_model/categories_model.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/modules/categories/categories_screen.dart';
import 'package:shopapp/modules/favourites/favourites_screen.dart';
import 'package:shopapp/modules/home/home_screen.dart';
import 'package:shopapp/modules/settings/settings_screen.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(InitialShopState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;

  List<Widget> BottomNavPages = [
    homeScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];

  void ChangeBottomNavPage(int index){
    CurrentIndex = index;
    emit(ChangeBottomNavPageState());
  }

  HomeModel? homeModel;

  homeData(){
    emit(LoadingShopState());
    DioHelper.getData(url: home).then((value) {
    homeModel = HomeModel.fromJson(value.data);
    emit(SuccessShopState());
    print(homeModel!.status.toString());
    print(homeModel!.data!.products![0].image);
    print(homeModel!.data!.banners![0].image);}
    ).catchError((onError){
      print(onError.toString());
    emit(ErrorShopState(onError));
    });
  }

  CategoriesModel? categoriesmodel;

  CategoriesData(){
    emit(LoadingCategoriesState());
    DioHelper.getData(url: categories).then((value) {
      print('sss');
      categoriesmodel = CategoriesModel.fromJson(value.data);
      print(categoriesmodel!.status.toString());
      emit(SuccessCategoriesState());
      print(categoriesmodel!.data!.data![0].name);
    }
    ).catchError((error){
      emit(ErrorCategoriesState());
      print(error);
    });
  }
}