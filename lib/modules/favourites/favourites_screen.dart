import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_cubit.dart';
import 'package:shopapp/layout/cubit/shop_states.dart';
import 'package:shopapp/models/favourite_model/get_favourites_model.dart';
import 'package:shopapp/shared/components/components.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {},
      builder:(context,state) => ConditionalBuilder(
        condition: state is! LoadingGetFavoritesState,
        builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => BuildProductItem(ShopCubit.get(context).getFavModel!.data!.data![index].product,context),
            separatorBuilder: (context,index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(color: Colors.grey,height: 1,),
            ),
            itemCount: ShopCubit.get(context).getFavModel!.data!.data!.length),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}