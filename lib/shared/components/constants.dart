import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

void signout(context) => CacheHelper.removeData(key: 'token').then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()))
);

