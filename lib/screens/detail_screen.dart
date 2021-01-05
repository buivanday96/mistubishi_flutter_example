import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mistubishi_example_app/models/trucks.dart';
import 'package:mistubishi_example_app/utils/screen_utils.dart';
import 'package:mistubishi_example_app/screens/pdf_screen.dart';
import 'package:mistubishi_example_app/screens/photos_screen.dart';
import 'package:mistubishi_example_app/screens/video_screen.dart';
import 'package:mistubishi_example_app/utils/color_util.dart';
import 'package:page_transition/page_transition.dart';

class DetailScreen extends StatefulWidget {
  final Trucks trucks;
  final String categoryName;
  const DetailScreen({Key key, this.trucks, this.categoryName}) : super(key: key);
  // default features is selected
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  GlobalKey _pdfKey = GlobalKey();
  Trucks _truck;
  String _categoryName;

  int indexSelected = 0;
  int indexDpfSelected = -1;
  Color colorSelected = MyColor.GREEN;

  double _currentOpacity = 1;

  _isSelected(int index) {
    indexSelected = index;
  }

  @override
  void initState() {
    super.initState();
    _truck = widget.trucks;
    _categoryName = widget.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    var _paddingLeftDevider = ScreenUtils().getWidthScreen(context) * 3 / 9 * (1 / 7);
    var _paddingRightDevider = ScreenUtils().getWidthScreen(context) * 3 / 9 * (1 / 2.75);

    var _name = _truck.nameCode;

    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Left part
            Expanded(
                flex: 6,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Custom App Bar
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.black,
                          child: _customAppbar(),
                        )),

                    // Image
                    Expanded(
                      flex: 10,
                      child: Hero(
                        tag: 'image${_truck.id}${_truck.nameCode}$_categoryName',
                        child: Container(
                          color: Colors.white,
                          child: Image.asset('assets/truck_item.jpg'),
                        ),
                      ),
                    )
                  ],
                )),

            // Right part
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    //Background
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/background.jpg'))),
                    ),
                    // Option
                    Column(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Container(
                              color: MyColor.GRAY,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 1000,
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: _listIcon(),
                                      ),
                                    ),
                                  ),

                                  // Divider , Name truck , TextScroll
                                  Expanded(
                                    flex: 2875,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Divider
                                          Padding(
                                            padding: EdgeInsets.only(left: _paddingLeftDevider, top: 20, bottom: 15),
                                            child: Divider(
                                              color: MyColor.GREEN,
                                              thickness: 3,
                                              endIndent: _paddingRightDevider,
                                            ),
                                          ),

                                          // Name truck
                                          Padding(
                                            padding: EdgeInsets.only(left: _paddingLeftDevider - 2, bottom: 15),
                                            child: Text(
                                              _name,
                                              style: TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                          ),

                                          // Text Scroll
                                          Expanded(child: _customTextScrollView(_paddingLeftDevider)),

                                          // Spacer Bottom
                                          SizedBox(
                                            height: 100,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Spacer(
                          flex: 1,
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _customAppbar() {
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

  Widget _listIcon() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(),
          _customIcon('assets/ic_forklift_truck.svg', text: 'FEATURES', index: 0, onTap: () {}),
          _customIcon(
            'assets/ic_pdf_file.svg',
            text: 'PDF',
            index: 1,
          ),
          _customIcon('assets/ic_play_button.svg', text: 'VIDEO', index: 2, onTap: () {
            Navigator.of(context).push(PageTransition(
              child: VideosScreen(),
              type: PageTransitionType.rightToLeftWithFade,
            ));
          }),
          _customIcon('assets/ic_image.svg', text: 'PHOTOS', index: 3, onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return PhotoScreen();
            // }));
            Navigator.push(
                context,
                PageTransition(
                  child: PhotoScreen(),
                  type: PageTransitionType.rightToLeftWithFade,
                ));
          }),
          Spacer()
        ],
      ),
    );
  }

  Widget _customIcon(String path,
      {String text = 'text', double width = 36, double height = 36, int index = -1, Function onTap}) {
    return Expanded(
        flex: 10, child: _customIconText(path, text: text, width: width, height: height, index: index, onTap: onTap));
  }

  Widget _customIconText(String path,
      {String text = 'text', double width = 36, double height = 36, int index = -1, Function onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          key: index == 1 ? _pdfKey : GlobalKey(),
          onTap: () {
            setState(() {
              _isSelected(index);
            });
            onTap != null ? onTap() : print('other');
          },
          onTapDown: (TapDownDetails details) {
            RenderBox box = _pdfKey.currentContext.findRenderObject();
            Offset offset = box.localToGlobal(Offset.zero);
            index == 1 ? _showPopupMenu(offset) : print('other');
          },
          child: SvgPicture.asset(
            path,
            color: index == this.indexSelected ? colorSelected : Colors.white,
            width: width,
            height: height,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            text,
            style: TextStyle(color: Colors.white60, fontSize: 12, fontFamily: 'GloriaHallelujah'),
          ),
        )
      ],
    );
  }

  Widget _customTextScrollView(double padding,
      {String text =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet porta nisi. Nam maximus euismod massa, at pretium sapien semper ac. Nam pharetra, magna ac ultrices sodales, diam lectus tempor nibh, eget volutpat est felis vel felis. Donec sed tristique ipsum, quis lobortis dui. Fusce lobortis feugiat neque. ' +
              'Nullam pulvinar odio at pretium volutpat. Proin et nunc gravida, tempor lacus eget, placerat velit. Ut varius, ligula id ultricies blandit, enim arcu auctor neque, eu porttitor sem tellus ut enim.'}) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: padding,
                right: padding,
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ));
  }

  void _showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    double size = ScreenUtils().getHeightWidget(_pdfKey);

    print(left);
    await showMenu(
      context: context,
      color: Colors.black,
      position: RelativeRect.fromLTRB(left - size, top + size, left, 0),
      items: [
        PopupMenuItem(
          height: 32,
          child: _textItemMenu('SPEC'),
          value: 1,
        ),
        PopupMenuItem(
          height: 32,
          child: _textItemMenu('OPTIONS'),
          value: 2,
        ),
        PopupMenuItem(
          height: 32,
          child: _textItemMenu('CAPACITY'),
          value: 3,
        ),
        PopupMenuItem(
          height: 32,
          child: _textItemMenu('SPECMANUAL'),
          value: 4,
        ),
      ],
      elevation: 8.0,
    ).then<void>((newValue) {
      if (!mounted) return null;
      switch (newValue) {
        case 1:
          print(1);
          Navigator.of(context).push(PageTransition(
            child: PdfScreen(),
            type: PageTransitionType.rightToLeftWithFade,
          ));
          break;
        case 2:
          print(2);
          break;
        case 3:
          print(3);
          break;
        case 4:
          print(4);
          break;
      }
    });
  }

  Widget _textItemMenu(String text, {bool disable = false}) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(color: disable ? MyColor.GRAY7C : Colors.white),
        ),
      );
}
