import 'package:flutter/material.dart';
import 'package:shopapp/layout/cubit/shop_cubit.dart';
import 'package:shopapp/models/categories_model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => CreateCategory(ShopCubit.get(context).categoriesmodel!.data!.data[index]),
        separatorBuilder: (context,index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(color: Colors.grey,height: 1,),
        ),
        itemCount: ShopCubit.get(context).categoriesmodel!.data!.data!.length);
  }
}

Widget CreateCategory(dataModel model) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Image(image: NetworkImage('${model.image}'), fit: BoxFit.cover,height: 100,width: 100,),
        SizedBox(width: 10,),
        Text('${model.name}',style: TextStyle(fontWeight: FontWeight.w800),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
