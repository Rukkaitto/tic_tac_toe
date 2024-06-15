import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'my_transition_animation_widget.dart';

class MyTransitionPage<T> extends CustomTransitionPage<T> {
  MyTransitionPage({required super.child})
      : super(
          transitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return MyTransitionAnimationWidget(
              child: child,
            );
          },
        );
}
