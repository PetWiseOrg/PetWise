import 'package:flutter/material.dart'; 


class VetClinicPage extends StatefulWidget {
  const VetClinicPage({super.key});

  @override
  VetClinicPageState createState() => VetClinicPageState();
}

class VetClinicPageState extends State<VetClinicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vet Clinic'),
      ),
      body: const Center(
        child: Text('No clinics available.'),
      ),
    );
  }
}