import 'package:petwise/ui/common_widgets/borders/themed_border_side.dart';
import 'package:petwise/ui/common_widgets/containers/themed_container_no_borders.dart';
import 'package:petwise/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemedTextField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final double? height;
  final String? hintText;
  final TextStyle? hintStyle;

  /// Determines the border width for all edges of the container.
  ///
  /// This value is not used if `borderSide` is not `null`.
  final double? borderWidth;

  /// Determines the borderSides for all egdes of the container.
  final ThemedBorderSide? borderSide;

  final bool alternateColors;
  final BorderRadius? borderRadius;
  final double? borderRadiusValue;
  final bool obscureText;
  final TextInputType? keyboardType; // New property

  const ThemedTextField({
    super.key,
    required this.controller,
    this.borderSide,
    this.borderWidth,
    this.borderRadiusValue,
    this.borderRadius,
    this.width,
    this.height,
    this.hintText,
    this.hintStyle,
    this.alternateColors = false,
    this.obscureText = false,
    this.keyboardType, // New property initialization
  });

  @override
  Widget build(BuildContext context) {
    final fillColor = !alternateColors ? secondary : primary;
    BorderRadius finalBorderRadius =
        radiusLogic(borderRadius, borderRadiusValue);

    BorderSide finalBorderSide;
    if (borderSide != null) {
      finalBorderSide = borderSide!.getBorderSide();
    } else {
      finalBorderSide = ThemedBorderSide(
              width: borderWidth, alternateColors: !alternateColors)
          .getBorderSide();
    }

    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType, // Use the new property
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          enabledBorder: OutlineInputBorder(
            borderRadius: finalBorderRadius,
            borderSide: finalBorderSide,
          ),
          filled: true,
          fillColor: fillColor,
        ),
      ),
    );
  }
}
