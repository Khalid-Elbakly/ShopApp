import 'package:shopapp/models/login_model/login_model.dart';

abstract class RegisterStates{}

class RegisterIntialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final Registermodel;
  RegisterSuccessState(this.Registermodel);
}

class RegisterErrorState extends RegisterStates{
  final error;

  RegisterErrorState(this.error);
}

class RegisterPasswordVisibaltiy extends RegisterStates{}
