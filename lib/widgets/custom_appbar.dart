import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  double _currentOpacity = 1;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 250),
      opacity: _currentOpacity,
      child: GestureDetector(
        onTap: () {
          print('onBack');
          Navigator.pop(context);
        },
        onTapUp: (TapUpDetails tapUpDetails) {
          print('onTapUp');
          setState(() {
            _currentOpacity = 1;
          });
        },
        onTapDown: (TapDownDetails tapDownDetails) {
          print('onTapDown');
          setState(() {
            _currentOpacity = 0.5;
          });
        },
        onTapCancel: () {
          print('onTapCancel');
          setState(() {
            _currentOpacity = 1;
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Left Icon
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 20, right: 10),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 35,
              ),
            ),

            // Banner
            Hero(
              tag: 'banner',
              child: Container(
                child: AspectRatio(
                  aspectRatio: 6 / 2,
                  child: Image.asset('assets/logo-mits.png'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
