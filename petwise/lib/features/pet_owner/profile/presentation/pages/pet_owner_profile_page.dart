import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/core/navigation/routing.dart';
import 'package:petwise/core/theme/app_theme.dart';
import 'package:petwise/features/pet_owner/pet/presentation/pages/pet_owner_provider_class.dart';
import 'package:provider/provider.dart';

class PetOwnerProfilePage extends StatefulWidget {
  const PetOwnerProfilePage({super.key});

  @override
  _PetOwnerProfilePageState createState() => _PetOwnerProfilePageState();
}

class _PetOwnerProfilePageState extends State<PetOwnerProfilePage> {
  void _addNewPet(Pet pet) {
    context.read<PetOwnerProvider>().addPet(pet); // Update global PetOwner
  }

  @override
  Widget build(BuildContext context) {
    final petOwner = context.watch<PetOwnerProvider>().petOwner;

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          ProfileHeader(petOwner: petOwner),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: ListView(
                children: [
                  ...petOwner.pets.map((pet) => PetCard(pet: pet)), // Show pet list
                  AddPetButton(onPetAdded: _addNewPet), // Add new pet
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.petOwner});

  final PetOwner petOwner;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [
          CircleAvatar(radius: 40, backgroundColor: Colors.purple[100], child: const Icon(Icons.person, size: 40, color: Colors.purple)),
          const SizedBox(height: 10),

          Text(petOwner.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(petOwner.address, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),

          const SizedBox(height: 10),

          IconButton(icon: const Icon(Icons.edit, color: Colors.white), onPressed: () {}),
        ],
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;
  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final updatedPet = await context.pushNamed(AppRoute.editPetPage.name, extra: pet);

        if (updatedPet != null && updatedPet is Pet) {
          // Handle pet updates dynamically if needed (e.g., call a parent function)
        }
      },
      child: Card(
        color: Colors.grey[300],
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.purple[100],
            child: const Icon(Icons.pets, size: 30, color: Colors.purple),
          ),
          title: Text(
            pet.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          trailing: const Icon(Icons.edit, size: 18),
        ),
      ),
    );
  }
}

class AddPetButton extends StatelessWidget {
  final Function(Pet) onPetAdded;

  const AddPetButton({super.key, required this.onPetAdded});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final newPet = await context.pushNamed(
          AppRoute.editPetPage.name,
          extra: Pet(name: '', age: 0, weight: 0.0, species: 'Dog', breed: 'Labrador'),
        );

        if (newPet != null && newPet is Pet) {
          onPetAdded(newPet); // Add pet to the list
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
          ),
          onPressed: () async {
            final newPet = await context.pushNamed(
              AppRoute.editPetPage.name,
              extra: Pet(name: '', age: 0, weight: 0.0, species: 'Dog', breed: 'Labrador'),
            );

            if (newPet != null && newPet is Pet) {
              onPetAdded(newPet);
            }
          },
          icon: const Icon(Icons.add, color: Colors.black),
          label: const Text('Add Pet', style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}