import 'package:flutter/material.dart';

class ClinicDetailsPage extends StatelessWidget {
  final String clinicName;
  final double rating;
  final String description;
  final String address;

  const ClinicDetailsPage({
    super.key,
    required this.clinicName,
    required this.rating,
    required this.description,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Clinic Details', style: TextStyle(color: Colors.black)),
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
                // Clinic Name
                Text(
                  clinicName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),

                // Rating
                Row(
                  children: [
                    _buildStarRating(rating),
                    const SizedBox(width: 8),
                    Text('$rating / 5',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        )),
                  ],
                ),
                const SizedBox(height: 20),

                // Clinic Description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),

                // Map Placeholder
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.map, size: 80, color: Colors.black38),
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  address,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Schedule button pressed!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Schedule Here'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget to build the Star Rating Row
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
