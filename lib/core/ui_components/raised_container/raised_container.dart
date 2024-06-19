import 'package:flutter/material.dart';

class RaisedContainer extends StatelessWidget {
  const RaisedContainer({
    required this.child,
    this.width,
    this.height,
    super.key,
  });

  final Widget child;
  final double? width;
  final double? height;

  static const double _borderWidth = 5.0;
  static const double _borderRadius = 25.0;
  static const Offset _shadowOffset = Offset(7.0, 5.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
          width: _borderWidth,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: _shadowOffset,
          ),
        ],
      ),
      child: child,
    );
  }
}
