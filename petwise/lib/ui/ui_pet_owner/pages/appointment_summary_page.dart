import 'package:flutter/material.dart';

class AppointmentSummaryPage extends StatelessWidget {
  final String clinicName;
  final double rating;
  final String concernsSummary;
  final DateTime appointmentDateTime;
  final String address;

  const AppointmentSummaryPage({
    super.key,
    required this.clinicName,
    required this.rating,
    required this.concernsSummary,
    required this.appointmentDateTime,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Appointment Request Summary', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Clinic Info Row
              // Clinic Info Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Clinic Name
                        Text(
                          clinicName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Rating
                        Row(
                          children: [
                            _buildStarRating(rating),
                            const SizedBox(width: 6),
                            Text('$rating / 5',
                                style: const TextStyle(fontSize: 14, color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Address
                        Text(
                          address,
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.map, size: 40, color: Colors.black38),
                      ),
                    ),
                  ),
                ],
              ),


                const SizedBox(height: 30),

                // Summary of Concerns
                const Text(
                  'Summary of Concerns',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  concernsSummary,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),

                const SizedBox(height: 30),

                // Appointment Date/Time
                const Text(
                  'Appointment Date/Time',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatDateTime(appointmentDateTime),
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),

          // Submit Request Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appointment request submitted!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Submit Request'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to format date/time nicely
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.month}/${dateTime.day}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildStarRating(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;

    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(const Icon(Icons.star, color: Colors.amber, size: 24));
      } else if (i == fullStars && halfStar) {
        stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 24));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 24));
      }
    }
    return Row(children: stars);
  }
}