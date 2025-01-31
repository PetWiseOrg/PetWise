import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:petwise/core/common_widgets/themed_confetti_widget.dart';
import 'package:petwise/core/navigation/routing.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/features/authentication/domain/auth_provider.dart';

class VerifyEmailPage extends StatefulWidget {
  final String email;
  final String password;

  const VerifyEmailPage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final _controller = ConfettiController(duration: const Duration(seconds: 3));
  late final PocketBase pb;
  String _message = 'Check your Email Inbox to Verify your Account';
  Timer? _pollingTimer;

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pb = Provider.of<PocketBase>(context);
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.authenticateUser(widget.email, widget.password);

        if (authProvider.currentUser?.verified == true) {
          timer.cancel();
          setState(() {
            _message = 'Account Verified!';
          });
          _controller.play();
          if (context.mounted) {
            Future.delayed(const Duration(seconds: 5), () {
              context.goNamed(AppRoute.additionalInfo.name);
            });
          }
        }
      } catch (error) {
        // Handle error
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        ThemedConfettiWidget(
          controller: _controller,
          blastDirection: pi / 2,
          numberOfParticles: 40, // Add the required argument
        ),
      ],
    );
  }
}
