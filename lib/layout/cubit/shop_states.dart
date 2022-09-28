import 'package:shopapp/layout/cubit/shop_states.dart';

abstract class ShopStates{}

class InitialShopState extends ShopStates{}

class ChangeBottomNavPageState extends ShopStates{}

class LoadingShopState extends ShopStates{}

class SuccessShopState extends ShopStates{}

class ErrorShopState extends ShopStates {
  var error;
  ErrorShopState(this.error);
}

class LoadingCategoriesState extends ShopStates{}

class SuccessCategoriesState extends ShopStates{}

class ErrorCategoriesState extends ShopStates{}

class LoadingChangeFavoritesState extends ShopStates{}

class SuccessChangeFavoritesState extends ShopStates{}

class ErrorChangeFavoritesState extends ShopStates{}

class LoadingGetFavoritesState extends ShopStates{}

class SuccessGetFavoritesState extends ShopStates{}

class ErrorGetFavoritesState extends ShopStates{}

class LoadingGetDataState extends ShopStates{}

class SuccessGetDataState extends ShopStates{}

class ErrorGetDataState extends ShopStates{}

class LoadingUpdateDataState extends ShopStates{}

class SuccessUpdateDataState extends ShopStates{}

class ErrorUpdateDataState extends ShopStates{}


