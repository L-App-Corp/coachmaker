library coachmaker;

export './src/widgets/widget_point.dart';
export './src/models/coach_button_model.dart';
export './src/models/coach_model.dart';
export './src/widgets/arrow.dart';

import 'package:coachmaker/src/models/coach_model.dart';
import 'package:coachmaker/src/widgets/widget_main.dart';
import 'package:flutter/material.dart';

///enum coach maker control
///
enum CoachMakerControl { none, close }

class CoachMaker {

  ///first duration delay
  ///
  final Duration firstDelay;

  ///duration
  ///
  final Duration duration;

  ///x = horizontal
  ///y = vertical
  ///h = height
  ///w = width
  ///
  double x = 0, y = 0, h = 0, w = 0;

  ///overlay block tap
  ///
  OverlayEntry? overlayBlock;

  ///overlay entry variable
  ///
  OverlayEntry? overlayEntry;

  ///curren index initalList
  ///
  int currentIndex = 0;

  ///inital list from coach point
  ///
  final List<CoachModel> initialList;

  ///context
  ///
  final BuildContext context;

  ///skip boolean, you can set false if you want to hide skip button
  ///
  final Function()? skip;

  ///next step button options
  ///
  final BorderRadiusGeometry? widgetBorderRadius;

  /// On Barrier press
  /// 
  final Function()? onBarrierPressed;
  /// On widget press
  /// 
  final Function()? onWidgetPressed;

  ///constructor
  ///
  CoachMaker(
    this.context, {
    required this.initialList,
    this.firstDelay = const Duration(milliseconds: 1),
    this.duration = const Duration(seconds: 1),
    this.skip,
    this.widgetBorderRadius,
    this.onBarrierPressed,
    this.onWidgetPressed,
  });


  // Remove overlay
  void removeOverlay() {
    overlayBlock?.remove();
    overlayBlock = null;
    overlayEntry?.remove();
    overlayEntry = null;
  }

  ///build overlay block
  ///
  OverlayEntry buildOverlayBlock() {
    return OverlayEntry(builder: (context) {
      ///build widget main
      ///
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
      );
    });
  }

  ///build overlay
  ///
  OverlayEntry buildOverlay() {
    return OverlayEntry(builder: (context) {
      ///build widget main
      ///
      return WidgetMain(
        x: x - 8,
        y: y - 8,
        h: h + 16,
        w: w + 16,
        duration: duration,
        padding: 10,
        widgetBorderRadius: widgetBorderRadius,
        model: initialList[currentIndex],
        onBarrierPressed: () {
          removeOverlay();
          if (onBarrierPressed != null) {
            onBarrierPressed!();
          }
        },
        onWidgetPressed: () {
          removeOverlay();
          if (onWidgetPressed != null) {
            onWidgetPressed!();
          }
        },
      );
    });
  }

  ///method for show overlay
  ///
  void show() {
    try {
      Future.delayed(currentIndex == 0 ? firstDelay : const Duration(milliseconds: 1),
          () {
        RenderBox box = GlobalObjectKey(initialList[currentIndex].initial!)
            .currentContext!
            .findRenderObject() as RenderBox;

        Offset position = box.localToGlobal(Offset.zero);
        y = position.dy;
        x = position.dx;
        h = box.size.height;
        w = box.size.width;

        if (overlayEntry == null) {
          if (currentIndex == 0) {
            overlayBlock = buildOverlayBlock();
            Overlay.of(context).insert(overlayBlock!);
          }
          overlayEntry = buildOverlay();
          Overlay.of(context).insert(overlayEntry!);
        }
      });
    } catch (e) {
      removeOverlay();
    }
  }

}
