import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/navigation/routing.dart';
import 'package:petwise/ui/theme/app_theme.dart';
import 'package:petwise/ui/pet_owner/pet/presentation/pages/pet_owner_provider_class.dart';
import 'package:provider/provider.dart';

class PetOwnerDashboardPage extends StatelessWidget {
  const PetOwnerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PetOwner petOwner = context.watch<PetOwnerProvider>().petOwner;

    return Scaffold(
      backgroundColor: secondary,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: secondary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 75,),
              ProfileHeader(petOwner: petOwner,),
              const SizedBox(height: 50),
              const SectionTitle(title: 'Upcoming Appointments'),
              const Divider(),
              
              const SizedBox(height: 100),

              const SectionTitle(title: 'My Pets'),
              const Divider(),
              const SizedBox(height: 10),
              PetsList(),

              const SizedBox(height: 10,),
              const SectionTitle(title: 'Previous Appointments & Treatment Plans'),
              const Divider(),

              const SizedBox(height: 100,),
              
              const SectionTitle(title: 'Recent Chats'),
              const Divider(),

              const SizedBox(height: 100,),
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
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoute.petOwnerProfilePage.name, extra: petOwner);
          },
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.purple[100], 
            child: const Icon(Icons.person, size: 40, color: Colors.purple),
          ),
        ),
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
  const PetsList({super.key});

  @override
  Widget build(BuildContext context) {
    final petOwner = context.watch<PetOwnerProvider>().petOwner;

    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...petOwner.pets.map((pet) => PetAvatar(pet: pet)),
            AddPetButton(),
          ],
        ),
      ),
    );
  }
}

class PetAvatar extends StatelessWidget {
  final Pet pet;
  const PetAvatar({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoute.editPetPage.name, extra: pet); // Navigate to pet details page
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.purple[100],
              child: const Icon(Icons.pets, size: 30, color: Colors.purple),
            ),
            const SizedBox(height: 5),
            Text(pet.name, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class AddPetButton extends StatelessWidget {
  const AddPetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final newPet = await context.pushNamed(
          AppRoute.editPetPage.name,
          extra: Pet(name: '', age: 0, weight: 0.0, species: 'Dog', breed: 'Labrador'),
        );

        if (newPet != null && newPet is Pet) {
          context.read<PetOwnerProvider>().addPet(newPet);
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30, // Adjust the size to match other pet avatars
            backgroundColor: Colors.grey[400],
            child: const Icon(Icons.add, size: 30, color: Colors.black),
          ),
          const SizedBox(height: 5),
          const Text('New Pet', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}