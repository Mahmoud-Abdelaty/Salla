// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_string_interpolations, avoid_print
import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  late final String image;
  late final String title;
  late final String body;

  BoardingModel(
  {
    required this.title,
    required this.body,
    required this.image,
  });
}



class OnBoardingScreen extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding =
  [
    BoardingModel(
        title: 'On Board 1 Title',
        body : 'On Board 1 Body',
        image: 'assets/images/splash_1.png'
    ),
    BoardingModel(
        title: 'On Boarding 2 Title',
        body:  'On Boarding 2 Body',
        image: 'assets/images/splash_2.png'),
    BoardingModel(
        title: 'On Boarding 3 Title',
        body: 'On Boarding 3 Body',
        image: 'assets/images/splash_3.png'),
  ];

  bool isLast = false ;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value)
      {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(
              onPressed: ()
        {
          submit();
        },
              child: Text('Skip',
              style: TextStyle(
                fontSize: 15,
              ),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index)
                {
                  if(index == boarding.length-1)
                    {
                      setState(() {
                        isLast = true;
                      });
                    }
                  else
                    {
                      setState(() {
                        isLast = false;
                      });
                    }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5,
                      activeDotColor: Colors.indigo,
                    ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.indigo[400],
                    onPressed: () {
                      isLast ?
                      submit() :
                      boardController.nextPage(
                        duration: Duration(
                            milliseconds: 750
                        ),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
            image: AssetImage('${model.image}')
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      SizedBox(
        height: 15,
      ),
    ],
  );
}
