import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_cubit.dart';
import 'package:shopapp/layout/cubit/shop_states.dart';
import 'package:shopapp/models/favourite_model/get_favourites_model.dart';

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
            itemBuilder: (context, index) => FavouriteItem(ShopCubit.get(context).getFavModel!.data!.data![index].product,context),
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

Widget FavouriteItem(Product? model,context){
  return Container(
    height: 120,
    width: 120,
    child: Row(
      children: [
      Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image(
          image: NetworkImage('${model!.image}'),
          height: 120,
          width: 120,
        ),
        if (model.discount! > 0)
          Container(
            color: Colors.red,
            child: Text(
              'DISCOUNT',
              style: TextStyle(color: Colors.white70),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5),
          )
      ],
    ),
    SizedBox(
    width: 2,
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
            '${model.name}',
            style: TextStyle(fontWeight: FontWeight.w700),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  '${model.price?.round()}',
                  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 20,
                ),
                if (model.discount! > 0)
                  Text('${model.oldPrice}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.lineThrough)),
                Spacer(),
                IconButton(
                    onPressed: (){
                      ShopCubit.get(context).ChangeFavourites(model.id);
                    }, icon: ShopCubit.get(context).favourite[model.id]! ? Icon(Icons.favorite,color: Colors.red,) : Icon(Icons.favorite_border_rounded)),
              ],)
          ],
        ),
      ),
    ),
]
    ),
  );
}