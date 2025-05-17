import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ReverseTypewriterAnimatedText extends AnimatedText {
  final Duration speed;
  final String cursor;

  late AnimationController _controller;
  late Animation<int> _count;

  ReverseTypewriterAnimatedText(
    String text, {
    required TextStyle textStyle,
    this.speed = const Duration(milliseconds: 100),
    this.cursor = "|",
  }) : super(
          text: text,
          textStyle: textStyle,
          duration: Duration(milliseconds: text.length * 2 * speed.inMilliseconds),
        );

  @override
  void initAnimation(AnimationController controller) {
    _controller = controller;

    _count = StepTween(begin: 0, end: text.length).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5),
      ),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  Widget completeText(BuildContext context) {
    return Text('$text$cursor', style: textStyle);
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    final isDeleting = _controller.status == AnimationStatus.reverse;
    final currentLength = isDeleting ? text.length - _count.value : _count.value;
    final visibleText = text.substring(0, currentLength);
    return Text('$visibleText$cursor', style: textStyle);
  }
}
