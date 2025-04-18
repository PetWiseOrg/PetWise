import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapWithMarkers extends StatefulWidget {
  final String ownerAddress;
  final String clinicAddress;

  const MapWithMarkers({required this.ownerAddress, required this.clinicAddress, super.key});

  @override
  State<MapWithMarkers> createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  final Set<Marker> _markers = {};
  GoogleMapController? _mapController;
  LatLng? _center;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    try {
      final ownerLocations = await locationFromAddress(widget.ownerAddress);
      final clinicLocations = await locationFromAddress(widget.clinicAddress);

      final ownerLatLng = LatLng(ownerLocations.first.latitude, ownerLocations.first.longitude);
      final clinicLatLng = LatLng(clinicLocations.first.latitude, clinicLocations.first.longitude);

      setState(() {
        _markers.add(Marker(markerId: const MarkerId('owner'), position: ownerLatLng, infoWindow: const InfoWindow(title: "You")));
        _markers.add(Marker(markerId: const MarkerId('clinic'), position: clinicLatLng, infoWindow: const InfoWindow(title: "Clinic")));
        _center = LatLng(
          (ownerLatLng.latitude + clinicLatLng.latitude) / 2,
          (ownerLatLng.longitude + clinicLatLng.longitude) / 2,
        );
      });
    } catch (e) {
      print('Failed to load locations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_center == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 300,
      child: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition: CameraPosition(target: _center!, zoom: 12),
        markers: _markers,
      ),
    );
  }
}