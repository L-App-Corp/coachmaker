import 'package:coachmaker/src/widgets/arrow.dart';
import 'package:flutter/material.dart';

class CoachModel {
  CoachModel(
      {this.initial,
      required this.child,
      this.overlayColor,
      this.maxWidth,
      this.alignment = Alignment.center,
      this.arrowAlignment = TooltipPosition.bottomCenter});

  String? initial;
  Widget child;
  Color? overlayColor;
  double? maxWidth;
  AlignmentGeometry? alignment;
  TooltipPosition arrowAlignment;
}
