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

