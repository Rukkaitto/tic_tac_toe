import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../constants/rive/rive.dart';
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
  Widget _backgroundWidget = const SizedBox();
  bool _isAnimationCompleted = false;

  void onRiveEvent(RiveEvent event) {
    switch (event.name) {
      case RiveEvents.switchView:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _backgroundWidget = widget.child;
          });
        });
      case RiveEvents.completed:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _isAnimationCompleted = true;
          });
        });
      default:
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAnimationCompleted) {
      return widget.child;
    }

    return Stack(
      children: <Widget>[
        _backgroundWidget,
        RiveAnimation.asset(
          AssetService().rive.transition,
          fit: BoxFit.cover,
          onInit: (Artboard artboard) {
            final StateMachineController? controller =
                StateMachineController.fromArtboard(
              artboard,
              RiveStateMachines.stateMachine1,
            );
            controller?.addEventListener(onRiveEvent);
            artboard.addController(controller!);
          },
        ),
      ],
    );
  }
}
