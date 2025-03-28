import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:petwise/data/providers/user_provider.dart';
import 'package:petwise/navigation/routing.dart';

class NoConnectionPage extends StatefulWidget {
  const NoConnectionPage({super.key});

  @override
  State<NoConnectionPage> createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  int _retryCount = 0;
  bool _isChecking = true;
  static const int maxRetries = 5;
  static const int baseDelay = 1;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    while (_retryCount < maxRetries) {
      final authProvider = Provider.of<UserProvider>(context, listen: false);
      final hasConnection = await authProvider.hasConnectionToDB();

      if (hasConnection) {
        if (!mounted) return;
        context.goNamed(AppRoute.welcomePage.name);
        return;
      }

      setState(() {
        _retryCount++;
        _isChecking = false;
      });

      // Exponential backoff: 1s, 2s, 4s, 8s, 16s
      final delay = baseDelay * pow(2, _retryCount - 1);
      await Future.delayed(Duration(seconds: delay.toInt()));

      setState(() {
        _isChecking = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 64),
            const SizedBox(height: 16),
            const Text(
              'No Connection to Server',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_isChecking)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _retryCount = 0;
                    _isChecking = true;
                  });
                  _checkConnection();
                },
                child: const Text('Retry Connection'),
              ),
          ],
        ),
      ),
    );
  }
}
