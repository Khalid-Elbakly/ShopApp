import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_states.dart';
import 'package:shopapp/modules/categories/categories_screen.dart';
import 'package:shopapp/modules/favourites/favourites_screen.dart';
import 'package:shopapp/modules/home/home_screen.dart';
import 'package:shopapp/modules/settings/settings_screen.dart';

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
}