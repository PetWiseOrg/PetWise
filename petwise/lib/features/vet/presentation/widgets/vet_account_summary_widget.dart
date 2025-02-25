import 'package:flutter/material.dart';

class VetAccountSummaryWidget extends StatefulWidget {
  const VetAccountSummaryWidget({super.key});

  @override
  _VetAccountSummaryWidgetState createState() => _VetAccountSummaryWidgetState();
}

class _VetAccountSummaryWidgetState extends State<VetAccountSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Veterinarian',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'johndoe@example.com',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
           SizedBox(width: 16),
           CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/profile.jpg'), // Replace with the actual profile picture
          ),
        ],
      ),
    );
  }
}