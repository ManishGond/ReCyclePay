import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedRefreshButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Duration refreshDuration;

  const AnimatedRefreshButton({
    Key? key,
    required this.onPressed,
    this.refreshDuration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  _AnimatedRefreshButtonState createState() => _AnimatedRefreshButtonState();
}

class _AnimatedRefreshButtonState extends State<AnimatedRefreshButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 1000), // Adjust the duration as needed
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // Adjust the curve for desired easing effect
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startRefreshing() {
    setState(() {
      _isRefreshing = true;
    });
    _animationController.repeat();
    widget.onPressed();

    // Stop rotating after the specified duration
    Future.delayed(widget.refreshDuration, _stopRefreshing);
  }

  void _stopRefreshing() {
    setState(() {
      _isRefreshing = false;
    });
    _animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _isRefreshing ? null : _startRefreshing,
      icon: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value,
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
              size: 17,
            ),
          );
        },
      ),
    );
  }
}
