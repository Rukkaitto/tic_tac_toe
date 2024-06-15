import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../services/asset_service/asset_service.dart';

class MyTransitionAnimationWidget extends StatefulWidget {
  const MyTransitionAnimationWidget({required this.child, super.key});

  final Widget child;

  @override
  State<MyTransitionAnimationWidget> createState() =>
      _MyTransitionAnimationWidgetState();
}

class _MyTransitionAnimationWidgetState
    extends State<MyTransitionAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Widget _widgetMaskChild = Container();
  bool _isAnimationCompleted = false;

  @override
  void initState() {
    _startAnimation();
    super.initState();
  }

  void _startAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    final Tween<double> tween = Tween<double>(begin: 10.0, end: 0.0);

    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _animation = tween.animate(curvedAnimation);

    // When the animation reaches its mid point, change the child widget
    _animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _widgetMaskChild = widget.child;
        });

        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _isAnimationCompleted = true;
        });
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAnimationCompleted) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      child: _widgetMaskChild,
      builder: (BuildContext context, Widget? child) {
        return WidgetMask(
          blendMode: BlendMode.dstIn,
          mask: Transform.scale(
            scale: _animation.value,
            child: SvgPicture.asset(
              AssetService().svgs.crossMask,
              color: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
