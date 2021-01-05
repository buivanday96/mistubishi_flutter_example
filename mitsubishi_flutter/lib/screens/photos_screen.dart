import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mistubishi_example_app/utils/color_util.dart';
import 'package:mistubishi_example_app/widgets/custom_appbar.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final pageControll = PageController();

  List<String> list = [
    'assets/truck_item.jpg',
    'assets/truck_item.jpg',
    'assets/truck_item.jpg',
    'assets/truck_item.jpg',
    'assets/truck_item.jpg',
    'assets/truck_item.jpg'
  ];

  int _indexPager = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  child: MyAppBar(),
                )),

            // Image
            Expanded(
                flex: 10,
                child: Container(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        PageView(
                          controller: pageControll,
                          physics: BouncingScrollPhysics(),
                          onPageChanged: (index) {
                            setState(() {
                              _indexPager = index;
                            });
                          },
                          children: list.map((e) => Image.asset(e)).toList(),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: DotsIndicator(
                            dotsCount: list.length,
                            decorator: DotsDecorator(
                              size: Size.square(10),
                              color: MyColor.BLACK36,
                              activeSize: Size.square(10),
                              activeColor: MyColor.GREEN,
                            ),
                            position: _indexPager.toDouble(),
                          ),
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
