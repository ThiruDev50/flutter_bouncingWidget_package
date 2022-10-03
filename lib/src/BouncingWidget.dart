

import 'package:flutter/material.dart';

class BouncingWidgetInOut extends StatefulWidget {
  ///child widget to make animated
  final Widget child;

  ///on press call back function
  final VoidCallback onPressed;

  /// Bouncing Type
  final BouncingType bouncingType;

  ///Animation duration
  final Duration duration;

  ///scale factor for different devices
  final double scaleFactor;

  ///animation dissmissed value
  final double animationDismissionValue;

  ///animation completion value
  final double animationCompletionValue;

  const BouncingWidgetInOut(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.bouncingType = BouncingType.bounceInOnly,
      this.scaleFactor = 2,
      this.duration = const Duration(milliseconds: 300),
      this.animationDismissionValue = 0.0,
      this.animationCompletionValue = 0.1})
      : super(key: key);

  @override
  State<BouncingWidgetInOut> createState() => _BouncingWidgetInOutState();
}

class _BouncingWidgetInOutState extends State<BouncingWidgetInOut>
    with SingleTickerProviderStateMixin {
  ///values passing as input

  /// Child
  Widget get child => widget.child;

  /// onPressed method for the child. ( This is mandatory)
  VoidCallback get onPressed => widget.onPressed;

  /// Bouncing type of the widget should be specified. By default Bounce in only
  BouncingType get bouncingType => widget.bouncingType;

  /// Scale factor of which widget should be animated. By default scaleFactor is 2
  double get scaleFactor => widget.scaleFactor;

  /// How much time the animation should take to complete. By default 200
  Duration get duration => widget.duration;

  /// Animation dismission deemed value
  double get _lowerBound => widget.animationDismissionValue;

  ///Animation completion deemed value
  double get _upperBound => widget.animationCompletionValue;

  ///Local variables

  /// animation controller intialize
  late AnimationController animationController;

  /// Key for child, used to get the position of the child
  final GlobalKey key = GlobalKey();

  /// Scale should be calculated based on animaation controller value and scale factor
  late double scale;

  /// Setting this to false, once the bouncingIn animation done this value will change to true
  bool isBouncingInAnimationDone = false;

  @override
  void initState() {
    /// Add listener to listen the animation controller
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

  ///dispose animation controller
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  /// Build method where our acture widget is being created
  @override
  Widget build(BuildContext context) {
    ///Checking the widget bouncing type
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

/// Our actual widget
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

  ///Invoked first, Trigerred forward animation
  onTapDown(TapDownDetails tapDownDetails) {
    animationController.forward();
  }

  ///onTapUp trigger after onTapDown, For reversing animation
  onTapUp(TapUpDetails tapUpDetails) {
    ///Delaying the animation
    Future.delayed(duration, () {
      reverseAnimation();
    });
    onPressed();
  }

  ///reverse animation
  reverseAnimation() {
    if (mounted) {
      animationController.reverse();
      setState(() {
        /// once the animation is finished changed the bool value to true
        isBouncingInAnimationDone = true;
      });
    }
  }

  /// Handling if user long pressed widget
  onLongPressEnd(LongPressEndDetails details, BuildContext context) {
    final Offset touchPosition = details.globalPosition;

    /// if current position is on widget exectue on pressed method else just reverse the animation
    if (!isPositionOutsideChild(touchPosition)) {
      onPressed();
    }
    reverseAnimation();
  }

  /// Checking if current postion is on the widget or not after long press
  bool isPositionOutsideChild(Offset touchPosition) {
    final RenderBox? childRenderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (childRenderBox == null) {
      return true;
    }
    final Size childSize = childRenderBox.size;
    final Offset childPosition = childRenderBox.localToGlobal(Offset.zero);

    /// Checking if the current position is within the child after long press and dragged
    return (touchPosition.dx < childPosition.dx ||
        touchPosition.dx > childPosition.dx + childSize.width ||
        touchPosition.dy < childPosition.dy ||
        touchPosition.dy > childPosition.dy + childSize.height);
  }
}

enum BouncingType { bounceInOnly, bounceOutOnly, bounceInAndOut }
