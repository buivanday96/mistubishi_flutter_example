import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class MyPdfWidget extends StatelessWidget {
  final PdfController pdfController;
  final void Function(PdfDocument document) onDocumentLoaded;
  final void Function(int page) onPageChanged;
  const MyPdfWidget({
    Key key,
    @required this.pdfController,
    this.onDocumentLoaded,
    this.onPageChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _pdfView();
  }

  Widget _pdfView() => PdfView(
        controller: pdfController,
        onDocumentLoaded: (document) {
          onDocumentLoaded != null ? onDocumentLoaded(document) : print('null');
        },
        onPageChanged: (page) {
          onPageChanged != null ? onPageChanged(page) : print('null');
        },
        documentLoader: Center(
          child: CircularProgressIndicator(),
        ),
        pageBuilder: (pageImage, isCurrentIndex, animationController) {
          // Double tap scale
          final List<double> _doubleTapScales = <double>[1.0, 2.0, 3.0];

          //Double tap animation
          Animation<double> _doubleTapAnimation;
          void Function() _animationListener;

          Widget image = ExtendedImage.memory(
            pageImage.bytes,
            key: Key(pageImage.hashCode.toString()),
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (_) => GestureConfig(
              minScale: 1,
              maxScale: 3,
              animationMinScale: .75,
              animationMaxScale: 3.0,
              speed: 1,
              inertialSpeed: 100,
              inPageView: true,
              initialScale: 1.0,
              cacheGesture: false,
            ),
            enableSlideOutPage: true,
            onDoubleTap: (state) {
              final pointerDownPosition = state.pointerDownPosition;
              final begin = state.gestureDetails.totalScale;
              double end;

              _doubleTapAnimation?.removeListener(_animationListener);
              animationController
                ..stop()
                ..reset();

              if (begin == _doubleTapScales[0]) {
                end = _doubleTapScales[1];
              } else {
                if (begin == _doubleTapScales[1]) {
                  end = _doubleTapScales[2];
                } else {
                  end = _doubleTapScales[0];
                }
              }

              _animationListener = () {
                state.handleDoubleTap(scale: _doubleTapAnimation.value, doubleTapPosition: pointerDownPosition);
              };

              _doubleTapAnimation = animationController.drive(Tween<double>(begin: begin, end: end))
                ..addListener(_animationListener);

              animationController.forward();
            },
          );
          if (isCurrentIndex) {
            image = Hero(
              tag: 'pdf_view' + pageImage.pageNumber.toString(),
              child: image,
            );
          }
          return image;
        },
      );
}
