import 'package:flutter/material.dart';

class VetDashboardPage extends StatelessWidget {
  const VetDashboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vet Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Vet Dashboard',
            ),
          ],
        ),
      ),
    );
  }
}