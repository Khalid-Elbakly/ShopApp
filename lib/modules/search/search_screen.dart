import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_cubit.dart';
import 'package:shopapp/modules/search/cubit/cubit.dart';
import 'package:shopapp/modules/search/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder:(context,state) {
          return ConditionalBuilder(
            condition: state is! LoadingSearchState,
            builder:(context) => Scaffold(
            appBar: AppBar(title: Text('Search'),),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: SearchController,
                      decoration: InputDecoration(labelText: 'Search',border: OutlineInputBorder()),
                      onFieldSubmitted: (text){
                        SearchCubit.get(context).Search(text);
                      },
                    ),
                    SizedBox(height: 20,),
                    if(state is LoadingSearchState)
                    LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    if(state is SuccessSearchState)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => BuildProductItem(SearchCubit.get(context).model!.data!.data![index],context),
                            separatorBuilder: (context,index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(color: Colors.grey,height: 1,),
                            ),
                            itemCount: SearchCubit.get(context).model!.data!.data!.length),
                      ),
                  ],
                ),
              )
        ),
            fallback: (context) => CircularProgressIndicator(),
          );},
      ),
    );}
}


Widget ProductItem(model,context){
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
          //     if (model.discount! > 0)
          //       Container(
          //         color: Colors.red,
          //         child: Text(
          //           'DISCOUNT',
          //           style: TextStyle(color: Colors.white70),
          //         ),
          //         padding: EdgeInsets.symmetric(horizontal: 5),
          //       )
          //   ],
          // ),
          // SizedBox(
          //   width: 2,
          // ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           '${model.name}',
          //           style: TextStyle(fontWeight: FontWeight.w700),
          //           maxLines: 2,
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //         Spacer(),
          //         Row(
          //           children: [
          //             Text(
          //               '${model.price?.round()}',
          //               style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700),
          //             ),
          //             SizedBox(
          //               width: 20,
          //             ),
          //             if (model.discount! > 0)
          //               Text('${model.oldPrice}',
          //                   style: TextStyle(
          //                       color: Colors.grey,
          //                       fontWeight: FontWeight.w700,
          //                       decoration: TextDecoration.lineThrough)),
          //             Spacer(),
          //             IconButton(
          //                 onPressed: (){
          //                   ShopCubit.get(context).ChangeFavourites(model.id);
          //                 }, icon: ShopCubit.get(context).favourite[model.id]! ? Icon(Icons.favorite,color: Colors.red,) : Icon(Icons.favorite_border_rounded)),
          //           ],)
          //       ],
          //     ),
          //   ),
          // ),
    ])
  ]));
}