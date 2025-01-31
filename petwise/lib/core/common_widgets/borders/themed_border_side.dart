import 'package:petwise/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Automatically sets the color of the `BorderSide` for consistent theming.
class ThemedBorderSide {
  final double? width;
  final BorderStyle? style;
  final bool alternateColors;
  final BorderSide borderSide;

  ThemedBorderSide({
    this.width,
    this.style,
    this.alternateColors = false,
  }) : borderSide = BorderSide(
          color: alternateColors ? onSecondary : onPrimary,
          width: width ?? 2,
          style: style ?? BorderStyle.solid,
        );

  /// Returns the `BorderSide` object within `ThemedBorderSide`.
  BorderSide getBorderSide() {
    return borderSide;
  }
}
