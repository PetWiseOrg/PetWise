import 'package:petwise/ui/common_widgets/borders/themed_border.dart';
import 'package:petwise/ui/common_widgets/borders/themed_border_side.dart';
import 'package:petwise/ui/common_widgets/containers/themed_container_no_borders.dart';
import 'package:petwise/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// A container consitent with the theme of the app.
class ThemedContainer extends ThemedContainerNoBorders {
  /// Determines the border width for all edges of the container.
  ///
  /// This value is not used if [border] is set.
  final double? borderWidth;

  /// Determines the border of the container. Overrides `borderWidth` if set.
  ///
  /// Used if specific border styling is required. This includes differences such as:
  ///
  /// • `ThemedBorderSide` object's `borderStyle`.
  ///
  /// • Different sides of the container require different `ThemedBorderSide` objects.
  ///
  final ThemedBorder? border;

  const ThemedContainer({
    super.key,
    super.child,
    super.width,
    super.height,
    super.padding,
    super.margin,
    super.borderRadiusValue,
    super.borderRadius,
    super.alternateColors,
    super.elevation,
    this.borderWidth,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final double shownElevation = elevation ?? 0.0;
    final containerColor = alternateColors ? secondary : primary;

    Border finalBorder;
    if (border != null) {
      finalBorder = border!.getBorder();
    } else {
      final borderSide = ThemedBorderSide(
          width: borderWidth, alternateColors: alternateColors);
      finalBorder = ThemedBorder(borderSide: borderSide).getBorder();
    }

    BorderRadius finalBorderRadius =
        radiusLogic(borderRadius, borderRadiusValue);

    return Material(
      elevation: shownElevation,
      borderRadius: finalBorderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          border: finalBorder,
          borderRadius: finalBorderRadius,
        ),
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        child: child,
      ),
    );
  }
}
