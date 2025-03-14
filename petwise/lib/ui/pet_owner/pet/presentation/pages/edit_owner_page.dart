import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwise/data/models/pet_user.dart';
import 'package:petwise/data/models/user.dart';
import 'package:petwise/data/providers/pet_user_provider.dart';
import 'package:petwise/data/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditOwnerPage extends StatefulWidget {
  @override
  _EditOwnerPageState createState() => _EditOwnerPageState();
}

class _EditOwnerPageState extends State<EditOwnerPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _userIDController;
  late TextEditingController _addressController;
  String? profileImage;
  User? currentUser;
  PetUser? petUser;

  @override
  void initState() {
    super.initState();
    final userProvider = context.watch<AuthProvider>();
    final petUserProvider = context.watch<PetUserProvider>();

    currentUser = userProvider.currentUser;
    petUser = petUserProvider.currentPetUser;

    _firstNameController = TextEditingController(text: currentUser?.firstName ?? '');
    _lastNameController = TextEditingController(text: currentUser?.lastName ?? '');
    _userIDController = TextEditingController(text: petUser?.userId ?? '');
    _addressController = TextEditingController(text: petUser?.homeAddress ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userIDController.dispose();
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
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty 
    || _userIDController.text.isEmpty || _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both name and address.')),
      );
      return;
    }

    final updatedUserData = {
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
    };

    final updatedPetUserData = {
      "userID": _userIDController.text,
      "address": _addressController.text,
    };

    context.read<AuthProvider>().updateUser(currentUser!.id, updatedUserData);
    context.read<PetUserProvider>().updatePetUser(petUser!.id, updatedPetUserData);
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
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: "First Name"),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: "Last Name"),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _userIDController,
              decoration: const InputDecoration(labelText: "User ID"),
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