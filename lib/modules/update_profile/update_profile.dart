import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_cubit.dart';
import 'package:shopapp/layout/cubit/shop_states.dart';
import 'package:shopapp/layout/home_layout.dart';
import 'package:shopapp/modules/settings/settings_screen.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var model;
  @override
  void initState() {
    ShopCubit.get(context).UserData();
    model = ShopCubit.get(context).dataModel;
    super.initState();
  }
  var NameController = TextEditingController();
  var EmailController = TextEditingController();
  var PhoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,stata){},
        builder: (context,state) {
           model = ShopCubit.get(context).dataModel;

          NameController.text = model.data.name;
          EmailController.text = model.data.email;
          PhoneController.value = TextEditingValue(text: '${model.data.phone}');

          return ConditionalBuilder(
            condition: model != null,
            builder:(context) => Scaffold(
            appBar: AppBar(
              title: Text('Update Data'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(state is LoadingUpdateDataState)
                  LinearProgressIndicator(),
                  SizedBox(height: 30,),
                  TextFormField(controller: NameController,decoration: InputDecoration(prefixIcon: Icon(Icons.person,),labelText: 'Name',border: OutlineInputBorder(borderSide: BorderSide(width: 20)),),),
                  SizedBox(height: 30,),
                  TextFormField(controller: EmailController,decoration: InputDecoration(prefixIcon: Icon(Icons.email,),labelText: 'Email Address',border: OutlineInputBorder(borderSide: BorderSide(width: 20)),)),
                  SizedBox(height: 30,),
                  TextFormField(controller: PhoneController,decoration: InputDecoration(prefixIcon: Icon(Icons.phone,),labelText: 'Phone',border: OutlineInputBorder(borderSide: BorderSide(width: 20)),)),
                  SizedBox(height: 30,),
                  Container(
                    color: Colors.blue,
                    width: double.infinity,
                    child: TextButton(onPressed: (){
                       ShopCubit.get(context).UpdateData(NameController.text, EmailController.text, PhoneController.text,context);
                    }, child: Text('UPDATE DATA',style: TextStyle(color: Colors.white),),),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    color: Colors.blue,
                    width: double.infinity,
                    child: TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLayout()));
                    }, child: Text('CANCEL',style: TextStyle(color: Colors.white),),),
                  ),

                ],
              ),
            ),
        ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );});}
}
