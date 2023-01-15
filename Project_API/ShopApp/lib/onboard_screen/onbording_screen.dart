// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shopapp/shared/cache_helper.dart';
import 'package:shopapp/shared/companent.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/shop_login.dart';

class BoardingModel {
  final String image;

  final String titel;
  final String body;

  BoardingModel({required this.image, required this.titel, required this.body});
}

class OnBoard_Screen extends StatefulWidget {
  const OnBoard_Screen({Key? key}) : super(key: key);

  @override
  State<OnBoard_Screen> createState() => _OnBoard_ScreenState();
}

class _OnBoard_ScreenState extends State<OnBoard_Screen> {
  bool isLast = false;
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boarding = [
      BoardingModel(
          body: "Page 1", image: 'assets/images/hone.jpg', titel: 'Screen1'),
      BoardingModel(
          body: "Page 2", image: 'assets/images/hone.jpg', titel: 'Screen2'),
      BoardingModel(
          body: "Page 3", image: 'assets/images/hone.jpg', titel: 'Screen3'),
      // BoardingModel(body: "", image: '', titel: ''),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                "SKIP",
                style: TextStyle(color: Colors.deepOrange),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      print("last");
                      isLast = true;

                      setState(() {
                        // if (isLast) {
                        //   navigetorAndFinish(context, ShopLoginScreen());
                        // }

                        isLast = true;
                      });
                    } else {
                      isLast = false;
                      setState(() {
                        // isLast = false;
                      });
                    }
                  },
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => OnBoard(boarding[index]),
                  itemCount: boarding.length),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  count: boarding.length,
                  controller: pageController,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 3.0,
                      dotWidth: 10,
                      activeDotColor: Colors.deepOrange,
                      spacing: 6),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.easeInOutCubicEmphasized);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.saveData(key: 'onBording', value: true).then((value) {
      if (value) {
        navigetorAndFinish(context, ShopLoginScreen());
      }
    });
  }
}

Widget OnBoard(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        Text(
          model.titel,
          style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 25.0,
        ),
        Text(
          model.body,
          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
