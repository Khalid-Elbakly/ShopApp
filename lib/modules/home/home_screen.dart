import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_cubit.dart';
import 'package:shopapp/layout/cubit/shop_states.dart';
import 'package:shopapp/models/categories_model/categories_model.dart';
import 'package:shopapp/models/home_model/home_model.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesmodel != null,
          builder: (context) => buildHome(context),
          fallback: (context) => Center(child: CircularProgressIndicator())),
    );
  }

  Widget buildHome(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
              items: ShopCubit.get(context)
                  .homeModel!
                  .data!
                  .banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CATEGORIES',style: TextStyle(fontWeight: FontWeight.w700),),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => categoriesItem(
                          ShopCubit.get(context)
                              .categoriesmodel!
                              .data!
                              .data![index]),
                      separatorBuilder: (context, index) => SizedBox(width: 10,),
                      itemCount: ShopCubit.get(context).categoriesmodel!.data!.data!.length),
                ),
                SizedBox(height: 20,),
                Text("NEW PRODUCTS",style: TextStyle(fontWeight: FontWeight.w700),)
              ],
            ),
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(
                ShopCubit.get(context).homeModel!.data!.products.length,
                (index) => buildProductGrid(
                    ShopCubit.get(context).homeModel!.data!.products[index])),
            childAspectRatio: 1 / 1.58,
          ),
        ],
      ),
    );
  }

  Widget buildProductGrid(ProductsModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: 200,
              ),
              if (model.discount! > 0)
                Container(
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white70),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 3),
                )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${model.name}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(height: 1),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                '${model.price.round()}',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(
                width: 20,
              ),
              if (model.discount! > 0)
                Text('${model.oldPrice}',
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough)),
              Spacer(),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.favorite_border_rounded))
            ],
          ),
        ],
      ),
    );
  }

  Widget categoriesItem(dataModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${model.image}',),
          width: 100,
          fit: BoxFit.cover,
          height: 100,
        ),
        Container(
          color: Colors.black87,
          width: 100,
          child: Text(
            '${model.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
