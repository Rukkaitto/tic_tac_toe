import 'package:flutter/material.dart';

import '../../services/asset_service/asset_service.dart';
import '../../services/dependency_injection_service/dependency_injection_service.dart';
import '../../services/enviromnent_service/environment_service.dart';

class ScrollingBackground extends StatefulWidget {
  const ScrollingBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ScrollingBackground> createState() => _ScrollingBackgroundState();
}

class _ScrollingBackgroundState extends State<ScrollingBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller;

  static const Duration _duration = Duration(seconds: 16);
  static const double _upperBound = 512;
  static const double _size = 2048;

  @override
  void initState() {
    _controller = AnimationController(
      duration: _duration,
      upperBound: _upperBound,
      vsync: this,
    );

    _controller!.addListener(() {
      setState(() {});
    });

    // Don't animate the background in UI tests to avoid infinite pumpWidget
    if (!sl<EnvironmentService>().isUITest) {
      _controller!.repeat();
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -_controller!.value,
            left: -_controller!.value,
            child: SizedBox(
              width: _size,
              height: _size,
              child: Image.asset(
                AssetService().images.backgroundTile,
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}
