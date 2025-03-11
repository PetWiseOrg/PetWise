import 'package:confetti/confetti.dart';
import 'package:petwise/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// A confetti widget consitent with the theme of the app.
class ThemedConfettiWidget extends StatelessWidget {
  final ConfettiController controller;
  final double blastDirection;
  final int numberOfParticles;

  const ThemedConfettiWidget({
    super.key,
    required this.controller,
    required this.blastDirection,
    required this.numberOfParticles,
  });

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: controller,
      blastDirection: blastDirection,
      colors: const [primary, secondary, tertiary],
      numberOfParticles: numberOfParticles,
      blastDirectionality: BlastDirectionality.explosive,
    );
  }
}
