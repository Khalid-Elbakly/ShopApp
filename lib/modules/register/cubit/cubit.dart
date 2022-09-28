import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/modules/register/cubit/states.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterIntialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister(name,email, password,phone) {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: 'register',
        data: {'name' : name,'email': email, 'password': password,'phone': phone})
        .then((value) {
          loginModel = LoginModel.fromJson(value.data);
          //print(loginModel!.status);
          //print(loginModel?.message);
          emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  Icon suffixIcon = Icon(Icons.visibility_off_outlined);

  ChangePasswordVisibality(){
    isPassword = !isPassword;
    suffixIcon = isPassword? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined);
    emit(RegisterPasswordVisibaltiy());
  }
}
