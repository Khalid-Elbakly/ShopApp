import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/cubit/shop_states.dart';
import 'package:shopapp/layout/home_layout.dart';
import 'package:shopapp/models/categories_model/categories_model.dart';
import 'package:shopapp/models/favourite_model/change_favourite_model.dart';
import 'package:shopapp/models/favourite_model/get_favourites_model.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/modules/categories/categories_screen.dart';
import 'package:shopapp/modules/favourites/favourites_screen.dart';
import 'package:shopapp/modules/home/home_screen.dart';
import 'package:shopapp/modules/settings/settings_screen.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialShopState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;

  List<Widget> BottomNavPages = [
    homeScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];

  void ChangeBottomNavPage(int index) {
    CurrentIndex = index;
    emit(ChangeBottomNavPageState());
  }

  Map<int?, bool?> favourite = {};

  HomeModel? homeModel;

  homeData() {
    emit(LoadingShopState());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(SuccessShopState());
      print(homeModel!.status.toString());
      print(homeModel!.data!.products[0].image);
      print(homeModel!.data!.banners[0].image);
      homeModel!.data!.products.forEach((element) {
        favourite.addAll({
          element.id: element.inFavourites
        });
      });
      print(favourite);
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorShopState(onError));
    });
  }

  CategoriesModel? categoriesModel;

  CategoriesData() {
    emit(LoadingCategoriesState());
    DioHelper.getData(url: categories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.status.toString());
      emit(SuccessCategoriesState());
      print(categoriesModel!.data!.data[0].name);
    }).catchError((error) {
      emit(ErrorCategoriesState());
      print(error);
    });
  }

  ChangeFavouriteModel? changeFavouriteModel;


  ChangeFavourites(int? id) {
    favourite[id] = !favourite[id]!;
    DioHelper.postData(url: favorites, data: {'product_id': id}, token: token)
        .then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      if (!changeFavouriteModel!.status!) {
        favourite[id] = !favourite[id]!;
        Fluttertoast.showToast(msg: '${changeFavouriteModel!.message}');
      }
      FavouritesData();
      emit(SuccessChangeFavoritesState());
    })
        .catchError((error) {
      favourite[id] = !favourite[id]!;
      Fluttertoast.showToast(msg: error);
      emit(ErrorChangeFavoritesState());
    });
  }

  GetFavModel? getFavModel;

  FavouritesData() {
    emit(LoadingGetFavoritesState());
    DioHelper.getData(url: favorites, token: token).then((value) {
      getFavModel = GetFavModel.fromJson(value.data);
      print(getFavModel!.status.toString());
      emit(SuccessGetFavoritesState());
    }).catchError((error) {
      emit(ErrorGetFavoritesState());
      print(error);
    });
  }

  LoginModel? dataModel;

  UserData() {
    emit(LoadingGetDataState());
    DioHelper.getData(url: profile, token: token).then((value) {
      dataModel = LoginModel.fromJson(value.data);
      emit(SuccessGetDataState());
    }).catchError((error) {
      emit(ErrorGetDataState());
      print(error);
    });
  }

  LoginModel? updateModel;
  bool ll = true;

  UpdateData(name, email, phone, context) {
    emit(LoadingUpdateDataState());
    ll = false;
    DioHelper
        .putData(url: updateProfile,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone})
        .then((value) {
      updateModel = LoginModel.fromJson(value.data);
      Fluttertoast.showToast(msg: '${updateModel!.message}').then((value) {
        ll = true;
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeLayout()));
      });
        emit
        (
        SuccessUpdateDataState
        (
        )
        );
      }).catchError((error) {
        emit(ErrorUpdateDataState());
        print(error);
      });
    }

        }
