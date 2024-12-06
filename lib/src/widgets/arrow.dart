import 'package:flutter/material.dart';

/// [TooltipPosition] is used to define the desired position of the tooltip
enum TooltipPosition {
  topStart,
  topCenter,
  topEnd,
  bottomStart,
  bottomCenter,
  bottomEnd,
}

class TooltipArrowShapePainter extends ShapeBorder {

  const TooltipArrowShapePainter({required this.position});

  final TooltipPosition position;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only(top:0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return  Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  List<double> getOffsets() {
    List<double> offsets = [];
    switch (position) {
      case TooltipPosition.topStart:
        offsets = [-15, 15, -15, 15];
        break;
      case TooltipPosition.topCenter:
        offsets = [-15, 15, -15, 15];
        break;
      case TooltipPosition.topEnd:
        offsets = [-15, 15, -15, 15];
        break;
      case TooltipPosition.bottomStart:
        offsets = [15, -15, 15, -15];
        break;
      case TooltipPosition.bottomCenter:
        offsets = [15, -15, 15, -15];
        break;
      case TooltipPosition.bottomEnd:
        offsets = [15, -15, 15, -15];
        break;
    }
    return offsets;
  }

  double getRectDx(Rect rect) {
    switch (position) {
      case TooltipPosition.topStart:
        return rect.topLeft.dx+46;
      case TooltipPosition.topCenter:
        return rect.topCenter.dx;
      case TooltipPosition.topEnd:
        return rect.topRight.dx-46;
      case TooltipPosition.bottomStart:
        return rect.bottomLeft.dx+46;
      case TooltipPosition.bottomCenter:
        return rect.bottomCenter.dx;
      case TooltipPosition.bottomEnd:
        return rect.bottomRight.dx-46;
    }
  }

  double getRectDy(Rect rect) {
    switch (position) {
      case TooltipPosition.topStart:
        return rect.topLeft.dy;
      case TooltipPosition.topCenter:
        return rect.topCenter.dy;
      case TooltipPosition.topEnd:
        return rect.topRight.dy;
      case TooltipPosition.bottomStart:
        return rect.bottomLeft.dy;
      case TooltipPosition.bottomCenter:
        return rect.bottomCenter.dy;
      case TooltipPosition.bottomEnd:
        return rect.bottomRight.dy;
    }
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final offsetList = getOffsets();
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight);
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12)))
      ..moveTo(getRectDx(rect) + offsetList[0], getRectDy(rect))
      ..relativeLineTo(offsetList[1], offsetList[2])
      ..relativeLineTo(offsetList[3], offsetList[3])
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {

  }

  @override
  ShapeBorder scale(double t) => this;

}