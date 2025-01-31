import 'package:petwise/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// A container consitent with the theme of the app.
///
/// This version does not have any borders.
class ThemedRoundContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;

  /// Whether the alternate color scheme is used or not.
  ///
  /// Set to `true` to use the alternate colors.
  final bool alternateColors;

  /// A container consistent with the theme of the app
  const ThemedRoundContainer({
    super.key,
    this.child,
    this.width,
    this.padding,
    this.margin,
    this.elevation,
    this.alternateColors = false,
  });

  @override
  Widget build(BuildContext context) {
    final double shownElevation = elevation ?? 0.0;
    final containerColor = alternateColors ? secondary : primary;

    return Material(
      elevation: shownElevation,
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          shape: BoxShape.circle,
        ),
        width: width,
        padding: padding,
        margin: margin,
        child: child,
      ),
    );
  }
}
