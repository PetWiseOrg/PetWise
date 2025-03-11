import 'package:petwise/ui/common_widgets/borders/themed_border_side.dart';
import 'package:flutter/material.dart';

/// A class used to set the color to borders automatically.
///
/// Uses `ThemedBorderSide` instead of `BorderSide`.
class ThemedBorder {
  final Border border;

  /// Sets all sides to `borderSide`.
  ThemedBorder({
    ThemedBorderSide? borderSide,
  }) : border = Border(
          top:
              borderSide?.getBorderSide() ?? ThemedBorderSide().getBorderSide(),
          bottom:
              borderSide?.getBorderSide() ?? ThemedBorderSide().getBorderSide(),
          left:
              borderSide?.getBorderSide() ?? ThemedBorderSide().getBorderSide(),
          right:
              borderSide?.getBorderSide() ?? ThemedBorderSide().getBorderSide(),
        );

  /// Used if specific sides need to be set.
  ThemedBorder.sides({
    ThemedBorderSide? top,
    ThemedBorderSide? bottom,
    ThemedBorderSide? right,
    ThemedBorderSide? left,
  }) : border = Border(
          top: top?.getBorderSide() ?? ThemedBorderSide().getBorderSide(),
          bottom: bottom?.getBorderSide() ?? ThemedBorderSide().getBorderSide(),
          right: right?.getBorderSide() ?? ThemedBorderSide().getBorderSide(),
          left: left?.getBorderSide() ?? ThemedBorderSide().getBorderSide(),
        );

  /// Returns the `Border` object within `ThemedBorder`.
  Border getBorder() {
    return border;
  }
}
