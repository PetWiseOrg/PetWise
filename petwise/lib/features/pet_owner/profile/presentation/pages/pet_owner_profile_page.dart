import 'package:flutter/material.dart';
import 'package:petwise/core/theme/app_theme.dart';
import 'package:petwise/features/pet_owner/pet/presentation/pages/pet_class.dart';

class PetOwnerProfilePage extends StatelessWidget {
  const PetOwnerProfilePage({super.key, required this.petOwner});

  final PetOwner petOwner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
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
              child: ListView.builder(
                itemCount: petOwner.pets.length + 1,
                itemBuilder: (context, index) {
                  if (index < petOwner.pets.length) {
                    return PetCard(pet: petOwner.pets[index]);
                  } else {
                    return const AddPetButton();
                  }
                },
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
  const PetCard({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      child: ExpansionTile(
        leading: CircleAvatar(radius: 30, backgroundColor: Colors.purple[100], child: const Icon(Icons.pets, size: 30, color: Colors.purple)),
        title: Text(pet.name, style: TextStyle(color: softBlack)),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Age: ${pet.age}", style: TextStyle(color: softBlack)),
                Text("Weight: ${pet.weight}", style: TextStyle(color: softBlack)),
                
                const SizedBox(height: 8),
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditPetPage(pet: pet)),
                    );
                  },
                  child: const Text('Edit Pet', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddPetButton extends StatelessWidget {
  const AddPetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
      onPressed: () {},
      icon: const Icon(Icons.add, color: Colors.black),
      label: const Text('Pet', style: TextStyle(color: Colors.black)),
    );
  }
}
