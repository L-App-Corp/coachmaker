import 'package:coachmaker/src/models/coach_model.dart';
import 'package:coachmaker/src/widgets/arrow.dart';
import 'package:flutter/material.dart';

class WidgetCard extends StatefulWidget {
  final double x, y, h, w;
  final bool enable;
  final CoachModel model;
  final Duration duration;

  const WidgetCard({
    super.key,
    required this.enable,
    required this.x,
    required this.y,
    required this.h,
    required this.w,
    required this.model,
    required this.duration,
  });

  @override
  WidgetCardState createState() => WidgetCardState();
}

class WidgetCardState extends State<WidgetCard> {
  ///top position
  ///
  double top = 0;

  ///height
  ///
  double h = 0;

  ///width
  ///
  double w = 0;

  ///horizontal
  ///
  double x = 0;

  ///vertical
  ///
  double y = 0;

  ///height card
  ///
  double hCard = 0;

  ///width card
  ///
  double wCard = 0;

  ///current page card
  ///
  int currentPage = 0;

  double? arrowHeight;

  ///init state
  ///
  @override
  void initState() {
    super.initState();
    start();
  }

  ///start method (animation, show, etc)
  ///
  void start() async {
    Future.delayed(Duration.zero, () {
      ///card global key attribute
      ///
      RenderBox box = const GlobalObjectKey('pointWidget1234567890')
          .currentContext!
          .findRenderObject() as RenderBox;

      ///set attribute to variables
      ///
      setState(() {
        hCard = box.size.height;
        wCard = box.size.width;
      });
    });

    ///delay 1.5 seconds
    ///
    // await Future.delayed(Duration(milliseconds: 1005));
    await Future.delayed(widget.duration);

    ///set position
    ///
    setState(() {
      x = widget.x;
      y = widget.y;
      h = widget.h;
      w = widget.w;

      top = x + h + 24;
    });
  }

  @override
  Widget build(BuildContext context) {
    final left = MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
              ?

              ///potrait
              ///
              0
              :

              ///lanscape
              ///
              x + w < (MediaQuery.of(context).size.width / 2)
                  ? h > hCard
                      ? x - (w / 2) + 8
                      : (x + w * -1) - 8
                  : (x < (MediaQuery.of(context).size.width / 2)
                      ? h > hCard
                          ? x + w + wCard > MediaQuery.of(context).size.width
                              ? x - wCard
                              : x - (w / 2) + 8
                          : 0
                      : x - w - (w / 2) - wCard - 16);
    final top = MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
          ?

          ///potrait
          ///
          y + h + hCard + (0) >
                  MediaQuery.of(context).size.height
              ? y - hCard - (24)
              : y + h + 24
          :

          ///landscape
          ///
          y > MediaQuery.of(context).size.height / 2
              ? y - hCard - (24)
              : y < (MediaQuery.of(context).size.height / 2)
                  ? y + h > hCard
                      ? y
                      : y + h + 8
                  : x < (MediaQuery.of(context).size.width / 2)
                      ? y
                      : y + h + 8;
    return Positioned(
      left: left.toDouble(),
      top: top.toDouble(),
      child: Material(
        color: Colors.transparent,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: top == 0
              ? 0
              : widget.enable
                  ? 1
                  : 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: widget.model.alignment!,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: widget.model.maxWidth ?? MediaQuery.of(context).size.width - 32,
                  key: const GlobalObjectKey('pointWidget1234567890'),
                  decoration: ShapeDecoration(
                    shape: TooltipArrowShapePainter(
                      position: widget.model.arrowAlignment
                    ),
                    color: widget.model.overlayColor ?? Colors.white,
                  ),
                  child: widget.model.child
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}