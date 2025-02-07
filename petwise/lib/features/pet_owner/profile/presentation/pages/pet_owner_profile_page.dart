import 'package:flutter/material.dart';
import 'package:petwise/features/pet_owner/pet/presentation/pages/pet_class.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.petOwner});

  final PetOwner petOwner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
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
          ProfileHeader(petOwner: petOwner,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pets:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: petOwner.pets.length,
                      itemBuilder: (context, index) {
                        return PetCard(pet: petOwner.pets[index]);
                      },
                    ),
                  ),
                  AddPetButton(),
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
          CircleAvatar(radius: 40, backgroundColor: Colors.purple[100], child: Icon(Icons.person, size: 40, color: Colors.purple)),
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
        leading: CircleAvatar(backgroundColor: Colors.grey),
        title: Text(pet.name!),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Age: ${pet.age}"),
                Text("Weight: ${pet.weight}"),
                
                const SizedBox(height: 8),
                
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
