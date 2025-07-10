import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  final Color dotColor;
  final double dotSize;
  final Duration speed;

  const TypingIndicator({
    super.key,
    this.dotColor = Colors.grey,
    this.dotSize = 6,
    this.speed = const Duration(milliseconds: 200),
  });

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.speed * 7, // 7 steps per full cycle
    )..repeat();

    _animations = List.generate(3, (i) {
      final start = i * 0.15;
      final end = start + 0.7;
      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.2), weight: 1), // e
        TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.4), weight: 1), // b
        TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.2), weight: 1), // c
        TweenSequenceItem(tween: Tween(begin: 1.2, end: 0.8), weight: 1), // i
        TweenSequenceItem(tween: ConstantTween(0.8), weight: 3),         // pause
      ]).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeInOut),
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: Container(
        width: widget.dotSize,
        height: widget.dotSize,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: widget.dotColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _animations.map(_buildDot).toList(),
    );
  }
}
