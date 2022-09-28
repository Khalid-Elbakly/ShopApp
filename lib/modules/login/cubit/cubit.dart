import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<loginStates> {
  LoginCubit() : super(loginIntialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin(email, password) {
    emit(loginLoadingState());
    DioHelper.postData(
        url: 'login',
        data: {'email': email, 'password': password})
        .then((value) {
          loginModel = LoginModel.fromJson(value.data);
          //print(loginModel!.status);
          //print(loginModel?.message);
          emit(loginSuccessState(loginModel));
    }).catchError((error) {
      print(error);
      emit(loginErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  Icon suffixIcon = Icon(Icons.visibility_off_outlined);

  ChangePasswordVisibality(){
    isPassword = !isPassword;
    suffixIcon = isPassword? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined);
    emit(loginPasswordVisibaltiy());
  }
}
