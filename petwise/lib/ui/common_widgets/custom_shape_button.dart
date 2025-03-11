import 'dart:math';

import 'package:petwise/ui/common_widgets/containers/themed_container.dart';
import 'package:petwise/ui/common_widgets/containers/themed_container_no_borders.dart';
import 'package:petwise/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomShapeButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget? child;
  final double? width;
  final double? height;
  final double? borderRadiusValue;
  final double elevation;
  final bool alternateColors;
  final bool borders;

  const CustomShapeButton({
    super.key,
    required this.onTap,
    required this.child,
    this.width,
    this.height,
    this.borderRadiusValue,
    this.elevation = 0.0,
    this.alternateColors = false,
    this.borders = true,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = borderRadiusValue ?? 8;
    // the -2 accounts for default border width
    final double splashBorderRadius = max(borderRadius - 2, 0);

    final splashColor = alternateColors ? onSecondary : onPrimary;

    if (borders) {
      return ThemedContainer(
        width: width,
        height: height,
        elevation: elevation,
        borderRadiusValue: borderRadius,
        alternateColors: alternateColors,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(splashBorderRadius),
            splashColor: splashColor.withOpacity(0.5),
            highlightColor: splashColor.withOpacity(0.3),
            onTap: onTap,
            child: child,
          ),
        ),
      );
    } else {
      return ThemedContainerNoBorders(
        width: width,
        height: height,
        elevation: elevation,
        borderRadiusValue: borderRadius,
        alternateColors: alternateColors,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(splashBorderRadius),
            splashColor: splashColor.withOpacity(0.5),
            highlightColor: splashColor.withOpacity(0.3),
            onTap: onTap,
            child: child,
          ),
        ),
      );
    }
  }
}
