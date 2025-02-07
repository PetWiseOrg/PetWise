import 'package:flutter/material.dart';
import 'package:petwise/features/pet_owner/pet/presentation/pages/pet_class.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.petOwner});

  final PetOwner petOwner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(petOwner: petOwner,),
              const SectionTitle(title: 'Upcoming Appointments'),
              const Divider(),
              
              const SizedBox(height: 10),

              const SectionTitle(title: 'My Pets'),
              const SizedBox(height: 10),
              PetsList(pets: petOwner.pets),
              const Divider(),
              
              const SectionTitle(title: 'Previous Appointments & Treatment Plans'),
              const Divider(),
              
              const SectionTitle(title: 'Recent Chats'),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.petOwner});

  final PetOwner petOwner;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hello,', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(petOwner.name, style: const TextStyle(fontSize: 22)),
          ],
        ),
        CircleAvatar(radius: 40, backgroundColor: Colors.purple[100], child: const Icon(Icons.person, size: 40, color: Colors.purple)),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class PetsList extends StatelessWidget {
  const PetsList({super.key, required this.pets});
  final List<Pet> pets;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // Ensures proper height for horizontal scrolling
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...pets.map((pet) => PetAvatar(petName: pet.name)),
            const AddPetButton(),
          ],
        ),
      ),
    );
  }
}

class PetAvatar extends StatelessWidget {
  final String petName;
  const PetAvatar({super.key, required this.petName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(radius: 30, backgroundColor: Colors.purple[100], child: const Icon(Icons.pets, size: 30, color: Colors.purple)),
          const SizedBox(height: 5),
          Text(petName, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}


class AddPetButton extends StatelessWidget {
  const AddPetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(radius: 30, backgroundColor: Colors.grey[400], child: const Icon(Icons.add, size: 30, color: Colors.black)),
          ),
          
          const SizedBox(height: 5),
          
          const Text('New Pet', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}