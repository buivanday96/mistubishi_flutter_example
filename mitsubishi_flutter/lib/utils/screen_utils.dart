import 'package:flutter/material.dart';

class ScreenUtils {
  double getWidthScreen(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getHeightScreen(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  Offset getOffset(GlobalKey key) {
    RenderBox box = key.currentContext.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    return offset;
  }

  double getHeightWidget(GlobalKey key) {
    return key.currentContext.size.height;
  }

  double getWidthWidget(GlobalKey key) {
    return key.currentContext.size.height;
  }
}
