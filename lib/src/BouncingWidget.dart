// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BouncingWidgetInOut extends StatefulWidget {
  //child widget to make animated
  final Widget child;

  //on press call back function
  final VoidCallback onPressed;

  // Bouncing Type
  final BouncingType bouncingType;
  //Animation duration
  final Duration duration;

  //scale factor for different devices
  final double scaleFactor;

  //animation dissmissed value
  final double animationDismissionValue;

  //animation completion value
  final double animationCompletionValue;

  const BouncingWidgetInOut(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.bouncingType = BouncingType.bounceInOnly,
      this.scaleFactor = 2,
      this.duration = const Duration(milliseconds: 100),
      this.animationDismissionValue = 0.0,
      this.animationCompletionValue = 0.1})
      : super(key: key);

  @override
  State<BouncingWidgetInOut> createState() => _BouncingWidgetInOutState();
}

class _BouncingWidgetInOutState extends State<BouncingWidgetInOut>
    with SingleTickerProviderStateMixin {
  //values passing as input
  Widget get child => widget.child;
  VoidCallback get onPressed => widget.onPressed;
  BouncingType get bouncingType => widget.bouncingType;
  double get scaleFactor => widget.scaleFactor;
  Duration get duration => widget.duration;
  double get _lowerBound => widget.animationDismissionValue;
  double get _upperBound => widget.animationCompletionValue;

  //Local variables
  late AnimationController animationController;
  final GlobalKey key = GlobalKey();
  late double scale;
  bool isBouncingInAnimationDone = false;

  @override
  void initState() {
    // Add listener to listen the animation controller
    animationController = AnimationController(
      vsync: this,
      duration: duration,
      lowerBound: _lowerBound,
      upperBound: _upperBound,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  //dispose animation controller
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (bouncingType == BouncingType.bounceInOnly) {
      scale = 1 - (animationController.value * scaleFactor);
    } else if (bouncingType == BouncingType.bounceOutOnly) {
      scale = 1 + (animationController.value * scaleFactor);
    } else {
      if (isBouncingInAnimationDone) {
        scale = 1 + (animationController.value * scaleFactor);
        if (scale == 1) {
          isBouncingInAnimationDone = false;
        }
      } else {
        scale = 1 - (animationController.value * scaleFactor);
      }
    }

    return Container(
        margin: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(
          onTapUp: onTapUp,
          onTapDown: onTapDown,
          onLongPressEnd: (val) => onLongPressEnd(val, context),
          child: Transform.scale(
            key: key,
            scale: scale,
            child: child,
          ),
        ));
  }

  //Invoked first, Trigerred forward animation
  onTapDown(TapDownDetails tapDownDetails) {
    animationController.forward();
  }

  //onTapUp trigger after onTapDown, For reversing animation
  onTapUp(TapUpDetails tapUpDetails) {
    Future.delayed(duration, () {
      reverseAnimation();
    });
    onPressed();
  }

  //reverse animation
  reverseAnimation() {
    if (mounted) {
      animationController.reverse();
      setState(() {
        isBouncingInAnimationDone = true;
      });
    }
  }

  // Handling if user long pressed widget
  onLongPressEnd(LongPressEndDetails details, BuildContext context) {
    final Offset touchPosition = details.globalPosition;

    // if current position is on widget exectue on pressed method else just reverse the animation
    if (!isPositionOutsideChild(touchPosition)) {
      onPressed();
    }
    reverseAnimation();
  }

  // Checking if current postion is on the widget or not after long press
  bool isPositionOutsideChild(Offset touchPosition) {
    final RenderBox? childRenderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (childRenderBox == null) {
      return true;
    }
    final Size childSize = childRenderBox.size;
    final Offset childPosition = childRenderBox.localToGlobal(Offset.zero);

    return (touchPosition.dx < childPosition.dx ||
        touchPosition.dx > childPosition.dx + childSize.width ||
        touchPosition.dy < childPosition.dy ||
        touchPosition.dy > childPosition.dy + childSize.height);
  }
}

enum BouncingType { bounceInOnly, bounceOutOnly, bounceInAndOut }
