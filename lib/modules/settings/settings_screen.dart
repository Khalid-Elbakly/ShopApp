import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_cubit.dart';
import 'package:shopapp/layout/cubit/shop_states.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/modules/update_profile/update_profile.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context)=> ShopCubit()..UserData(),
     child : BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).dataModel;

        return ConditionalBuilder(
          condition: model != null,
          builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'NAME:',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        '${model!.data!.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'EMAIL:',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      Text('${model.data!.email}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(
                        'PHONE:',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        '${model.data!.phone}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateProfile()));
                              },
                              child: Text('UPDATE PROFILE',style: TextStyle(color: Colors.white),))),
                      Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: TextButton(
                              onPressed: () {
                                CacheHelper.removeData(key: 'loginStatus');
                                CacheHelper.removeData(key: 'token').then(
                                    (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen())));
                              },
                              child: Text('LOGOUT',style: TextStyle(color: Colors.white),),)),
                    ],
                  ),
                ),
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()));},
    ));
  }
}
