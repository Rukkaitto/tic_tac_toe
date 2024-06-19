import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/text_styles.dart';
import '../raised_container/raised_container.dart';

class MyButton extends StatefulWidget {
  const MyButton({required this.text, required this.onPressed, super.key});

  final String text;
  final void Function()? onPressed;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  double _scale = 1.0;

  static const double _pressedScale = 0.95;
  static const double _initialScale = 1.0;
  static const Duration _duration = Duration(milliseconds: 400);
  static const double _height = 80.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _scale = _pressedScale;
        });

        HapticFeedback.lightImpact();
      },
      onTapUp: (_) {
        setState(() {
          _scale = _initialScale;
        });
        widget.onPressed?.call();
      },
      onTapCancel: () {
        setState(() {
          _scale = _initialScale;
        });
      },
      child: AnimatedScale(
        duration: _duration,
        scale: _scale,
        curve: Curves.elasticOut,
        child: RaisedContainer(
          height: _height,
          child: Text(
            widget.text,
            style: TextStyles.title,
          ),
        ),
      ),
    );
  }
}
