import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Salla'),),
      body: TextButton(child: Text('Sign Out'),onPressed: (){
        CacheHelper.removeData(key: 'token').then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()))
    );
      },),
    );
  }
}
