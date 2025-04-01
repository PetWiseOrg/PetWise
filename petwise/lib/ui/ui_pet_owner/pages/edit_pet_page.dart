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
  late TextEditingController _colorController;
  late TextEditingController _chipNumberController;
  late TextEditingController _tagNumberController;
  String? _selectedSex;
  String? petImage;
  DateTime _selectedBirthdate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet.name);
    _ageController = TextEditingController(text: widget.pet.age > 0 ? widget.pet.age.toString() : '');
    _weightController = TextEditingController(text: widget.pet.weight > 0 ? widget.pet.weight.toString() : '');
    _speciesController = TextEditingController(text: widget.pet.species);
    _breedController = TextEditingController(text: widget.pet.breed);
    _colorController = TextEditingController(text: widget.pet.color);
    _selectedSex = widget.pet.sex;
    _selectedBirthdate = widget.pet.birthdate;
    _chipNumberController = TextEditingController(text: widget.pet.chipNumber);
    _tagNumberController = TextEditingController(text: widget.pet.tagNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _speciesController.dispose();
    _breedController.dispose();
    _colorController.dispose();
    _chipNumberController.dispose();
    _tagNumberController.dispose();
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

  Future<void> _pickBirthdate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthdate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedBirthdate) {
      setState(() {
        _selectedBirthdate = picked;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isProcessing = true);

    try {
      final updatedPet = Pet(
        id: widget.pet.id,
        name: _nameController.text,
        age: double.tryParse(_ageController.text) ?? 0,
        weight: double.tryParse(_weightController.text) ?? 0,
        species: _speciesController.text,
        breed: _breedController.text,
        sex: _selectedSex ?? 'Unknown',
        birthdate: _selectedBirthdate,
        color: _colorController.text,
        chipNumber: _chipNumberController.text,
        tagNumber: _tagNumberController.text,
      );

      final petProvider = context.read<PetProvider>();
      final isNewPet = widget.pet.id.isEmpty;

      if (isNewPet) {
        context.pop(updatedPet); // Return the new pet to be created
      } else {
        await petProvider.updatePet(widget.pet.id, updatedPet.toJson());
        context.pop(updatedPet);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving pet: $e')),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNewPet = widget.pet.id.isEmpty;

      return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of a text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(isNewPet ? "Add New Pet" : "Edit ${widget.pet.name}"),
        ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: pickPetImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: petImage != null && petImage!.isNotEmpty ? FileImage(File(petImage!)) : null,
                  backgroundColor: Colors.purple[100],
                  child: petImage == null || petImage!.isEmpty ? const Icon(Icons.pets, size: 50, color: Colors.purple) : null,
                ),
              ),
              const SizedBox(height: 20),

              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Pet Name*",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your pet's name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Age Field
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: "Age (years)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (double.tryParse(value) == null) {
                      return "Please enter a valid number";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Weight Field
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: "Weight (kg)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (double.tryParse(value) == null) {
                      return "Please enter a valid number";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Species Field
              TextFormField(
                controller: _speciesController,
                decoration: const InputDecoration(
                  labelText: "Species",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the species";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Breed Field
              TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(
                  labelText: "Breed",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Color Field
              TextFormField(
                controller: _colorController,
                decoration: const InputDecoration(
                  labelText: "Color",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Birthdate Field
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Birthdate",
                  hintText: _selectedBirthdate.toString(),
                  border: const OutlineInputBorder(),
                ),
                onTap: _pickBirthdate,
              ),
              const SizedBox(height: 16),

              // Chip Number Field
              TextFormField(
                controller: _chipNumberController,
                decoration: const InputDecoration(
                  labelText: "Chip Number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Tag Number Field
              TextFormField(
                controller: _tagNumberController,
                decoration: const InputDecoration(
                  labelText: "Tag Number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Sex dropdown
              DropdownButtonFormField<String>(
                value: _selectedSex,
                decoration: const InputDecoration(
                  labelText: "Sex",
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female', 'Unknown']
                    .map((sex) => DropdownMenuItem(
                          value: sex,
                          child: Text(sex),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSex = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _isProcessing ? null : _saveChanges,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: _isProcessing ? const CircularProgressIndicator() : Text(isNewPet ? "Add Pet" : "Save Changes"),
              ),
            ],
          ),
        ),
      ),
      ),
      ),
    );
  }
}
