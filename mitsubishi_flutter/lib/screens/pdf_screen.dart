import 'package:flutter/material.dart';
import 'package:mistubishi_example_app/utils/color_util.dart';
import 'package:mistubishi_example_app/utils/screen_utils.dart';
import 'package:mistubishi_example_app/widgets/pdf_widget.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> with SingleTickerProviderStateMixin {
  final GlobalKey containerSliderKey = GlobalKey();
  final PdfController pdfController = PdfController(
    document: PdfDocument.openAsset('assets/zoompan.pdf'),
  );
  int _actualPageNumber = 1, _allPagesCount = 1;
  double slideValue = 1;
  bool chagingBySlide = false;

  AnimationController _controller;
  Animation<Offset> _offsetTopAnimation;
  Animation<Offset> _offsetBtmAnimation;
  int milisAnimation = 150;
  bool changeBySlider = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: milisAnimation), vsync: this);
    _offsetTopAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1.0),
    ).animate(_controller);
    _offsetBtmAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1.0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: _customPdf(),
          ),
        ),
      ),
    );
  }

  Widget _customPdf() {
    return Stack(
      children: [
        MyPdfWidget(
          pdfController: pdfController,
          onDocumentLoaded: (document) {
            setState(() {
              _allPagesCount = document.pagesCount;
            });
          },
          onPageChanged: (page) {
            if (!changeBySlider) {
              _animationStatus(possibleShow: false);
              setState(() {
                _actualPageNumber = page;
              });
            }
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: _gesture(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SlideTransition(
            position: _offsetBtmAnimation,
            child: _columnBottom(),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SlideTransition(
            position: _offsetTopAnimation,
            child: _customTop(),
          ),
        ),
      ],
    );
  }

  Widget _columnBottom() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(color: MyColor.BLACK_CC),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              '$_actualPageNumber/$_allPagesCount',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          key: containerSliderKey,
          decoration: BoxDecoration(color: MyColor.BLACK_CC),
          child: Slider(
            min: 1.0,
            max: _allPagesCount * 1.0,
            value: _actualPageNumber.toDouble(),
            onChanged: (value) {
              changeBySlider = true;
              setState(() {
                _actualPageNumber = value.toInt();
                print('$_allPagesCount $value $_actualPageNumber');
                pdfController.animateToPage(_actualPageNumber,
                    duration: Duration(milliseconds: 250), curve: Curves.ease);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _customTop() {
    //var height = ScreenUtils().getHeightWidget(containerSliderKey);
    return Container(
      decoration: BoxDecoration(
        color: MyColor.BLACK_CC,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.only(),
              child: Text(
                'DONE',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Text(
            'spec.pdf',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.only(),
              child: Text(
                'EMAIL',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buttonDirect(DirectClick option) {
    return Opacity(
      opacity: 0,
      child: GestureDetector(
        onTap: () {
          switch (option) {
            case DirectClick.Left:
              if (_actualPageNumber > 1) {
                pdfController.previousPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
              }

              break;
            case DirectClick.Right:
              if (_actualPageNumber < _allPagesCount) {
                pdfController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeIn);
              }
              break;
          }
        },
        child: Container(width: ScreenUtils().getWidthScreen(context) * 1 / 18, color: Colors.red),
      ),
    );
  }

  Widget _gesture() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buttonDirect(DirectClick.Left),
        Expanded(
            child: Container(
          child: Opacity(
            opacity: 0,
            child: GestureDetector(
              onTap: () {
                _animationStatus();
              },
            ),
          ),
        )),
        _buttonDirect(DirectClick.Right),
      ],
    );
  }

  void _animationStatus({bool possibleShow = true}) {
    switch (_controller.status) {
      case AnimationStatus.dismissed:
        _controller.forward();

        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.completed:
        if (possibleShow) {
          print('completed');
          _controller.reverse();
        }
        break;
    }
  }
}

enum DirectClick { Left, Right }
enum LayoutStatus { Hide, Show }
