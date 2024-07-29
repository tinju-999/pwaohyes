import 'package:flutter/material.dart';

class CommonAnimationSwitcher extends StatelessWidget {
  /// The widget to display as a child of the AnimatedSwitcher.
  final Widget child;

  /// The duration of the switch animation.
  final Duration duration;

  /// The curve used for the switch-in animation.
  final Curve switchInCurve;

  /// The curve used for the switch-out animation.
  final Curve switchOutCurve;

  /// The transition builder to customize the switch animation.
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

  /// Creates a CommonAnimatedSwitcher with customizable properties.
  const CommonAnimationSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.switchInCurve = Curves.easeIn,
    this.switchOutCurve = Curves.easeOut,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: transitionBuilder,
      child: child,
    );
  }
}
