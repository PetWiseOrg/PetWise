import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwise/features/pet_owner/pet/presentation/pages/pet_owner_provider_class.dart';
import 'package:provider/provider.dart';

class EditOwnerPage extends StatefulWidget {
  @override
  _EditOwnerPageState createState() => _EditOwnerPageState();
}

class _EditOwnerPageState extends State<EditOwnerPage> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  String? profileImage;

  @override
  void initState() {
    super.initState();
    final petOwner = context.read<PetOwnerProvider>().petOwner;
    _nameController = TextEditingController(text: petOwner.name);
    _addressController = TextEditingController(text: petOwner.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImage = image.path;
      });
    }
  }

  void _saveChanges() {
    if (_nameController.text.isEmpty || _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both name and address.')),
      );
      return;
    }

    final updatedOwner = PetOwner(
      name: _nameController.text,
      address: _addressController.text,
      pets: context.read<PetOwnerProvider>().petOwner.pets,
    );

    context.read<PetOwnerProvider>().updatePetOwner(updatedOwner);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.purple[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profileImage != null && profileImage!.isNotEmpty
                    ? FileImage(File(profileImage!))
                    : null,
                backgroundColor: Colors.purple[100],
                child: profileImage == null || profileImage!.isEmpty
                    ? const Icon(Icons.person, size: 50, color: Colors.purple)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // Name Field
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            const SizedBox(height: 10),

            // Address Field
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: "Address"),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}