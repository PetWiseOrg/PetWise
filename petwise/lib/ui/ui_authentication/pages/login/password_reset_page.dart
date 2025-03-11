import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:petwise/ui/common_widgets/themed_confetti_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/navigation/routing.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _controller = ConfettiController(duration: const Duration(seconds: 3));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.play();
    Future.delayed(const Duration(seconds: 3), () {
      context.pushNamed(AppRoute.loginPage.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0),
              child: Text(
                'If an associated account exists, reset instructions have been sent to your email.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        ThemedConfettiWidget(
          controller: _controller,
          blastDirection: pi / 2,
          numberOfParticles: 100,
        )
      ],
    );
  }
}
