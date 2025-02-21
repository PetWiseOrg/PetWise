import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/features/pet_owner/pet/presentation/pages/pet_owner_provider_class.dart';
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
  late String _selectedSpecies;
  late String _selectedBreed;

  final List<String> speciesOptions = ['Dog', 'Cat', 'Bird', 'Other'];
  final Map<String, List<String>> breedOptions = {
    'Dog': ['Labrador', 'Bulldog', 'Beagle', 'Golden Retriever'],
    'Cat': ['Siamese', 'Persian', 'Maine Coon', 'Bengal'],
    'Bird': ['Parrot', 'Canary', 'Cockatoo', 'Macaw'],
    'Other': ['Unknown']
  };

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet.name);
    _ageController = TextEditingController(text: widget.pet.age > 0 ? widget.pet.age.toString() : '');
    _weightController = TextEditingController(text: widget.pet.weight > 0 ? widget.pet.weight.toString() : '');
    _selectedSpecies = widget.pet.species.isNotEmpty ? widget.pet.species : speciesOptions.first;
    _selectedBreed = widget.pet.breed.isNotEmpty ? widget.pet.breed : breedOptions[_selectedSpecies]!.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a pet name.')));
      return;
    }

    final updatedPet = Pet(
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      weight: double.tryParse(_weightController.text) ?? 0.0,
      species: _selectedSpecies,
      breed: _selectedBreed,
    );

    // Update Pet in Provider
    final petOwnerProvider = context.read<PetOwnerProvider>();
    final petIndex = petOwnerProvider.petOwner.pets.indexWhere((p) => p.name == widget.pet.name);
    
    if (petIndex != -1) {
      petOwnerProvider.updatePet(petIndex, updatedPet);
    } else {
      petOwnerProvider.addPet(updatedPet);
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
            // Pet Avatar
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.pets, size: 50, color: Colors.purple),
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

            // Species Dropdown
            DropdownButtonFormField<String>(
              value: _selectedSpecies,
              decoration: const InputDecoration(labelText: "Species"),
              items: speciesOptions.map((species) {
                return DropdownMenuItem(
                  value: species,
                  child: Text(species),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSpecies = value!;
                  _selectedBreed = breedOptions[_selectedSpecies]!.first;
                });
              },
            ),
            const SizedBox(height: 20),

            // Breed Dropdown
            DropdownButtonFormField<String>(
              value: _selectedBreed,
              decoration: const InputDecoration(labelText: "Breed"),
              items: breedOptions[_selectedSpecies]!.map((breed) {
                return DropdownMenuItem(
                  value: breed,
                  child: Text(breed),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBreed = value!;
                });
              },
            ),
            const SizedBox(height: 30),

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