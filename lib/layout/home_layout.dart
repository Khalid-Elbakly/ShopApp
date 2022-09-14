import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_cubit.dart';
import 'package:shopapp/layout/cubit/shop_states.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/modules/search/search_screen.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return
        BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state) {},
        builder:(context,state) {
          var cubit = ShopCubit.get(context);

          return Scaffold(
          appBar: AppBar(elevation: 0 ,title: Text('Salla',style: TextStyle(color: Colors.black),),actions: [IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
          }, icon: Icon(Icons.search),color: Colors.black,)],backgroundColor: Colors.white,),
          body: cubit.BottomNavPages[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded),label: 'Favourites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
            currentIndex: ShopCubit.get(context).CurrentIndex,
            onTap: (value){
              ShopCubit.get(context).ChangeBottomNavPage(value);
            },
            selectedItemColor: Colors.blue,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          )
    );}
      );}
}
