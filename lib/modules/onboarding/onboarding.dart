import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String Title;
  final String Body;

  BoardingModel({required this.Body,required this.image,required this.Title});
}

void submit(context){
  CacheHelper.setData(key: 'OnBoarding', value: true).then((value){
    if(value)
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  });
}


class OnBoarding extends StatelessWidget {
   OnBoarding({Key? key}) : super(key: key);
   bool isLast = false;
  PageController BoardController = PageController();


  List<BoardingModel> boarding = [
    BoardingModel(Body: 'Screen Body 1',image: 'lib/shared/assets/images/shop.jpg',Title: 'Screen Title 1'),
    BoardingModel(Body: 'Screen Body 2',image: 'lib/shared/assets/images/shop.jpg',Title: 'Screen Title 2'),
    BoardingModel(Body: 'Screen Body 3',image: 'lib/shared/assets/images/shop.jpg',Title: 'Screen Title 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white70,elevation: 0,actions: [
        TextButton(onPressed: (){
          submit(context);
        }, child: Text('SKIP',style: TextStyle(fontWeight: FontWeight.w700),))
      ],),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(child:
            PageView.builder(itemBuilder: (context,index) => OnBoardingItem(boarding[index]),
            itemCount: boarding.length,
            controller: BoardController,
            physics: BouncingScrollPhysics(),
            onPageChanged: (index){
              if(boarding.length -1 == index){
                isLast = true;
              } else {
               isLast = false;
              }
            },),),
            SizedBox(height: 30,),
            Row(children: [
              SmoothPageIndicator(controller: BoardController, count: boarding.length,effect: ExpandingDotsEffect(activeDotColor: Colors.blue),),
              Spacer(),
              FloatingActionButton(
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: (){
                    if(isLast){
                      submit(context);
                    }
                    else{
                      BoardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                    }})
            ],)
          ],
        ),
      ),
    );
  }
   OnBoardingItem(BoardingModel boarding) => Column(
     crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${boarding.image}'))),
      SizedBox(height: 30,),
      Text('${boarding.Title}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),),
      SizedBox(height: 30,),
      Text('${boarding.Body}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25)),
    ],
   );
}
