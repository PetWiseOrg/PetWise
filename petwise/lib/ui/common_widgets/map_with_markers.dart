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
    final ownerLocs = await locationFromAddress(widget.ownerAddress);
    final clinicLocs = await locationFromAddress(widget.clinicAddress);

    if (ownerLocs.isEmpty || clinicLocs.isEmpty) {
      throw Exception("Could not geocode one or both addresses");
    }

    final ownerLatLng = LatLng(ownerLocs.first.latitude, ownerLocs.first.longitude);
    final clinicLatLng = LatLng(clinicLocs.first.latitude, clinicLocs.first.longitude);

    setState(() {
      _markers.add(Marker(markerId: const MarkerId('owner'), position: ownerLatLng));
      _markers.add(Marker(markerId: const MarkerId('clinic'), position: clinicLatLng));
      _center = LatLng(
        (ownerLatLng.latitude + clinicLatLng.latitude) / 2,
        (ownerLatLng.longitude + clinicLatLng.longitude) / 2,
      );
    });
  } catch (e) {
    print("📍 Address geocoding failed: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Failed to load map due to invalid address.")),
    );
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
