import 'package:flutter/material.dart';
import 'package:petwise/navigation/routing.dart';
import 'package:go_router/go_router.dart';

class FindClinicPage extends StatelessWidget {
  const FindClinicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteClinics = [
      {
        'name': 'Angell Animal Medical Center',
        'distance': 1.2,
        'rating': 4.9,
        'description': 'A nonprofit veterinary hospital in Boston offering 24/7 emergency and specialty care.',
        'address': '350 S Huntington Ave, Boston, MA 02130',
      },
      {
        'name': 'Schwarzman Animal Medical Center',
        'distance': 2.0,
        'rating': 4.8,
        'description': 'The world’s largest nonprofit animal hospital, providing comprehensive care in NYC.',
        'address': '510 E 62nd St, New York, NY 10065',
      },
    ];

    final nearbyClinics = [
      {
        'name': 'UC Davis Veterinary Medical Teaching Hospital',
        'distance': 0.5,
        'rating': 4.7,
        'description': 'A leading veterinary teaching hospital offering advanced care and training.',
        'address': '1 Garrod Dr, Davis, CA 95616',
      },
      {
        'name': 'BluePearl Pet Hospital – Tampa',
        'distance': 0.8,
        'rating': 4.6,
        'description': 'A specialty and emergency pet hospital providing advanced veterinary services.',
        'address': '3000 Busch Lake Blvd, Tampa, FL 33614',
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