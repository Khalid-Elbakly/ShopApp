import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_cubit.dart';
import 'package:shopapp/layout/home_layout.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/modules/onboarding/onboarding.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  var onBoarding = CacheHelper.getData(key: 'OnBoarding');
  var loginStatus = CacheHelper.getData(key: 'token');

  Widget widget;

  if (onBoarding != null) {
    if (loginStatus != null) {
      widget = HomeLayout();
    }
    else
      widget = LoginScreen();
  }
  else
    widget = OnBoarding();

  runApp(MyApp(homePage: widget,));
}


class MyApp extends StatelessWidget {
  Widget homePage;
  MyApp({Key? key,required this.homePage}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopCubit()..homeData()..CategoriesData(),
      child: MaterialApp(
            home: homePage,
            debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey
          )
        ),
          ),
    );
}
}