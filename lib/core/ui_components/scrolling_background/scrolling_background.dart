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

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 16),
      upperBound: 512,
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
              width: 2048,
              height: 2048,
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
