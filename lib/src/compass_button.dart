import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class CompassButton extends StatefulWidget {
  final MapController mapController;
  final double size;
  final Duration duration;
  final String assetPath;

  const CompassButton({
    Key? key,
    required this.mapController,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 250),
    this.assetPath = 'assets/compass.png',
  }) : super(key: key);

  @override
  State<CompassButton> createState() => _CompassButtonState();
}

class _CompassButtonState extends State<CompassButton> with SingleTickerProviderStateMixin {
  double _turns = 0.0;
  double _prevRotation = 0.0;
  late final AnimationController _animationController;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _rotationAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );

    // Tek seferlik listener
    _animationController.addListener(() {
      final rotationTween = Tween<double>(
        begin: widget.mapController.rotation,
        end: 0,
      );
      final newRotation = rotationTween.evaluate(_rotationAnimation);

      widget.mapController.rotate(newRotation);

      if (mounted) {
        //setState(() {
          _turns = newRotation / 360;
        //});
      }
    });

    widget.mapController.mapEventStream.listen(_onMapEvent);
  }

  void _onMapEvent(MapEvent event) {
    if (event is MapEventRotate) {
      double direction = event.currentRotation;
      direction = direction < 0 ? (360 + direction) : direction;

      double diff = direction - _prevRotation;

      if (diff.abs() > 180) {
        if (_prevRotation > direction) {
          diff = 360 - _prevRotation + direction;
        } else {
          diff = -(360 - direction + _prevRotation);
        }
      }

      setState(() {
        _turns += diff / 360;
        _prevRotation = direction;
      });
    }
  }

  void _animatedMapRotateToNorth() {
    if (_animationController.isAnimating) return;

    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: _turns,
      duration: widget.duration,
      child: InkWell(
        onTap: _animatedMapRotateToNorth,
        child: Image.asset(
          widget.assetPath,
          width: widget.size,
        ),
      ),
    );
  }
}
