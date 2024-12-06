import 'dart:async';

import 'package:coachmaker/coachmaker.dart';
import 'package:coachmaker/src/widgets/widget_card.dart';
import 'package:flutter/material.dart';

class WidgetMain extends StatefulWidget {
  final double x, y, h, w, padding;
  final BorderRadiusGeometry? widgetBorderRadius;
  final CoachModel model;
  final Duration duration;
  final Function()? onBarrierPressed;
  final Function()? onWidgetPressed;

  const WidgetMain({
    super.key,
    required this.x,
    required this.y,
    required this.h,
    required this.w,
    this.padding = 0,
    this.widgetBorderRadius,
    required this.duration,
    required this.model,
    this.onBarrierPressed,
    this.onWidgetPressed,
  });

  @override
  WidgetMainState createState() => WidgetMainState();
}

class WidgetMainState extends State<WidgetMain> {
  ///flag for show card
  ///
  bool enable = false;

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

  ///timer for animation hole overlay
  ///
  Timer? timer;

  ///init state
  ///
  @override
  void initState() {
    super.initState();
    start();
  }

  ///dispose
  ///
  @override
  void dispose() {
    // timer!.cancel();
    super.dispose();
  }

  ///start method (animation, show, etc)
  ///
  void start() async {
    ///await 1 miliseconds
    ///
    await Future.delayed(const Duration(milliseconds: 100));
 
    ///set default value
    ///
    setState(() {
      h = widget.h + (widget.padding * 2);
      w = widget.w + (widget.padding * 2);
      x = widget.x - widget.padding;
      y = widget.y - widget.padding;
    });

    ///set variables with timer
    ///
    setState(() {
        h = (h == widget.h + (widget.padding * 2))
            ? widget.h - (widget.padding)
            : widget.h + (widget.padding * 2);
        w = (w == widget.w + (widget.padding * 2))
            ? widget.w - (widget.padding)
            : widget.w + (widget.padding * 2);
        x = (x == widget.x - widget.padding)
            ? widget.x + (widget.padding / 2)
            : widget.x - widget.padding;
        y = (y == widget.y - widget.padding)
            ? widget.y + (widget.padding / 2)
            : widget.y - widget.padding;
      });
    // timer = Timer.periodic(widget.duration, (Timer t) {
      
    // });

    ///await 1 miliseconds
    ///
    await Future.delayed(widget.duration);

    ///show card
    ///
    setState(() {
      enable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ColorFiltered(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOut),
          child: Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.onBarrierPressed != null) {
                    widget.onBarrierPressed!();
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut),
                ),
              ),
              AnimatedPositioned(
                left: x+4,
                top: y+4,
                height: h == 0 ? MediaQuery.of(context).size.height : h-8,
                width: w == 0 ? MediaQuery.of(context).size.width : w-8,
                duration: widget.duration,
                curve: Curves.fastOutSlowIn,
                child: GestureDetector(
                  onTap: () async {
                    if (widget.onWidgetPressed != null) {
                      widget.onWidgetPressed!();
                    }
                  },
                  child: Container(
                    height: h == 0 ? MediaQuery.of(context).size.height : h,
                    width: w == 0 ? MediaQuery.of(context).size.width : w,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: widget.widgetBorderRadius ??
                            BorderRadius.circular(5)),
                  ),
                ),
              ),
            ],
          ),
        ),
        WidgetCard(
          duration: widget.duration,
          x: x,
          y: y,
          h: h,
          w: w,
          enable: enable,
          model: widget.model,
        )
      ],
    );
  }
}
