import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _scale = 0.95;
        });

        HapticFeedback.lightImpact();
      },
      onTapUp: (_) {
        setState(() {
          _scale = 1.0;
        });
        widget.onPressed?.call();
      },
      onTapCancel: () {
        setState(() {
          _scale = 1.0;
        });
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 400),
        scale: _scale,
        curve: Curves.elasticOut,
        child: RaisedContainer(
          height: 80.0,
          child: Text(
            widget.text,
            style: GoogleFonts.jost(
              color: Colors.black,
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
