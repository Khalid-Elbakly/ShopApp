abstract class ShopStates{}

class InitialShopState extends ShopStates{}

class ChangeBottomNavPageState extends ShopStates{}

class LoadingShopState extends ShopStates{}

class SuccessShopState extends ShopStates{}

class ErrorShopState extends ShopStates {
  var error;
  ErrorShopState(this.error);
}
