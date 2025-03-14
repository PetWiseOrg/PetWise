import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwise/data/models/pet.dart';
import 'package:petwise/data/providers/pet_provider.dart';
import 'package:provider/provider.dart';

class EditPetPage extends StatefulWidget {
  final Pet pet;

  const EditPetPage({super.key, required this.pet});

  @override
  _EditPetPageState createState() => _EditPetPageState();
}

class _EditPetPageState extends State<EditPetPage> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _speciesController;
  late TextEditingController _breedController;
  String? petImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet.name);
    _ageController = TextEditingController(text: widget.pet.age > 0 ? widget.pet.age.toString() : 'Unknown');
    _weightController = TextEditingController(text: widget.pet.weight > 0 ? widget.pet.weight.toString() : 'Unknown');
    _speciesController = TextEditingController(text: widget.pet.species);
    _breedController = TextEditingController(text: widget.pet.breed);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> pickPetImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        petImage = image.path;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a pet name.')));
      return;
    }

    final updatedPet = Pet(
      id: widget.pet.id,
      name: _nameController.text,
      age: double.parse(_ageController.text),
      weight: double.parse(_weightController.text),
      species: _speciesController.text,
      breed: _breedController.text,
      sex: widget.pet.sex,
      birthdate: widget.pet.birthdate,
      color: widget.pet.color,
      chipNumber: widget.pet.chipNumber,
      tagNumber: widget.pet.tagNumber,
    );

    final petProvider = context.read<PetProvider>();
    final petIndex = petProvider.pets.indexWhere((p) => p.id == widget.pet.id);

    if (petIndex != -1) {
      await petProvider.updatePet(widget.pet.id, updatedPet.toJson());
    } else {
      await petProvider.createPet(updatedPet.toJson());
    }

    context.pop(); // Go back after saving
  }

  @override
  Widget build(BuildContext context) {
    final isNewPet = widget.pet.name.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(isNewPet ? "Add New Pet" : "Edit ${widget.pet.name}"),
        backgroundColor: Colors.purple[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickPetImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: petImage != null && petImage!.isNotEmpty
                    ? FileImage(File(petImage!))
                    : null,
                backgroundColor: Colors.purple[100],
                child: petImage == null || petImage!.isEmpty
                    ? const Icon(Icons.pets, size: 50, color: Colors.purple)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // Name Field
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Pet Name"),
            ),
            const SizedBox(height: 10),

            // Age Field
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            // Weight Field
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: "Weight (kg)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Species Field
            TextField(
              controller: _speciesController,
              decoration: const InputDecoration(labelText: "Species"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Breed Field
            TextField(
              controller: _breedController,
              decoration: const InputDecoration(labelText: "Breed"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _saveChanges,
              child: Text(isNewPet ? "Add Pet" : "Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}