import 'package:flutter/material.dart';
import 'package:petwise/navigation/routing.dart';
import 'package:go_router/go_router.dart';

class FindClinicPage extends StatelessWidget {
  const FindClinicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteClinics = [
      {
        'name': 'Pawsitive Vets',
        'distance': 1.2,
        'rating': 4.8,
        'description': 'Compassionate care for your furry friends. Specializing in small pets and exotic animals.',
        'address': '101 Pet Avenue, Pet City',
      },
      {
        'name': 'Happy Tails Clinic',
        'distance': 2.0,
        'rating': 4.5,
        'description': 'Friendly staff and top-notch veterinary services for all types of pets.',
        'address': '500 Tail Waggers Rd, Pet City',
      },
    ];

    final nearbyClinics = [
      {
        'name': 'Whisker Wellness Center',
        'distance': 0.5,
        'rating': 4.2,
        'description': 'Expert veterinary services with a personal touch. Emergency services available.',
        'address': '12 Whisker Lane, Pet City',
      },
      {
        'name': 'Tail Waggers Veterinary',
        'distance': 0.8,
        'rating': 4.6,
        'description': 'Affordable wellness plans and dental care for dogs and cats.',
        'address': '800 Bark Blvd, Pet City',
      },
    ];

    nearbyClinics.sort((a, b) =>
      (a['distance'] as double).compareTo(b['distance'] as double));


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Find a Clinic', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('⭐ Favorite Clinics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          ...favoriteClinics.map((clinic) => ClinicCard(clinic: clinic)),

          const SizedBox(height: 24),
          const Text('📍 Nearby Clinics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          ...nearbyClinics.map((clinic) => ClinicCard(clinic: clinic)),
        ],
      ),
    );
  }
}

class ClinicCard extends StatelessWidget {
  final Map<String, dynamic> clinic;

  const ClinicCard({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      child: ListTile(
        title: Text(
          clinic['name'],
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${clinic['distance']} km • ${clinic['rating']}⭐',
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black),
        onTap: () {
          context.pushNamed(
            AppRoute.clinicDetailsPage.name,
            extra: {
              'clinicName': clinic['name'],
              'rating': clinic['rating'],
              'description': clinic['description'],
              'address': clinic['address'],
            },
          );
        },
      ),
    );
  }
}