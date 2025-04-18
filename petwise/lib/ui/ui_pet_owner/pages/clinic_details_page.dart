import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:petwise/navigation/routing.dart';

class ClinicDetailsPage extends StatefulWidget {
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
  State<ClinicDetailsPage> createState() => _ClinicDetailsPageState();
}

class _ClinicDetailsPageState extends State<ClinicDetailsPage> {
  final Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _markers = {};
  LatLng _initialPosition = const LatLng(37.7749, -122.4194); // fallback

  final String tempUserAddress = '2005 15th St, Troy 12180';

  @override
  void initState() {
    super.initState();
    _loadMapMarkers();
  }

  Future<void> _loadMapMarkers() async {
    try {
      final clinicLoc = await locationFromAddress(widget.address);
      final userLoc = await locationFromAddress(tempUserAddress);

      final clinicLatLng = LatLng(clinicLoc.first.latitude, clinicLoc.first.longitude);
      final userLatLng = LatLng(userLoc.first.latitude, userLoc.first.longitude);

      setState(() {
        _initialPosition = LatLng(
          (clinicLatLng.latitude + userLatLng.latitude) / 2,
          (clinicLatLng.longitude + userLatLng.longitude) / 2,
        );

        _markers = {
          Marker(
            markerId: const MarkerId('clinic'),
            position: clinicLatLng,
            infoWindow: InfoWindow(title: widget.clinicName),
          ),
          Marker(
            markerId: const MarkerId('user'),
            position: userLatLng,
            infoWindow: const InfoWindow(title: 'Your Address'),
          ),
        };
      });
    } catch (e) {
      print('Error geocoding addresses: $e');
    }
  }

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
                Text(widget.clinicName,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStarRating(widget.rating),
                    const SizedBox(width: 8),
                    Text('${widget.rating} / 5', style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 20),
                Text(widget.description,
                    style: const TextStyle(fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 30),

                // Map replaces placeholder
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initialPosition,
                        zoom: 12,
                      ),
                      markers: _markers,
                      onMapCreated: (controller) => _mapController.complete(controller),
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Text(widget.address,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(
                    AppRoute.appointmentSummaryPage.name,
                    extra: {
                      'clinicName': widget.clinicName,
                      'rating': widget.rating,
                      'concernsSummary': 'TODO: JSON from the text messages made in the Chat',
                      'appointmentDateTime': DateTime.now().add(const Duration(days: 2, hours: 3)),
                      'address': widget.address,
                    },
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