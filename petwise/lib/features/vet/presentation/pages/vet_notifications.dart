import 'package:flutter/material.dart';

class VetNotificationPage extends StatefulWidget {
  const VetNotificationPage({super.key});

  @override
  VetNotificationPageState createState() => VetNotificationPageState();
}

class VetNotificationPageState extends State<VetNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vet Notifications'),
      ),
      body: const Center(
        child: Text('No notifications available.'),
      ),
    );
  }
}