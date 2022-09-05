import 'package:shopapp/models/login_model/login_model.dart';

abstract class loginStates{}

class loginIntialState extends loginStates{}

class loginLoadingState extends loginStates{}

class loginSuccessState extends loginStates{
  final loginmodel;
  loginSuccessState(this.loginmodel);
}

class loginErrorState extends loginStates{
  final error;

  loginErrorState(this.error);
}

class loginPasswordVisibaltiy extends loginStates{}