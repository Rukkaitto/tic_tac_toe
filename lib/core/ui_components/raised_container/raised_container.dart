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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 5.0,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Offset(7.0, 5.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
