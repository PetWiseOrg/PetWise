import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/data/models/pet.dart';
import 'package:petwise/data/models/pet_user.dart';
import 'package:petwise/data/models/user.dart';
import 'package:petwise/data/providers/pet_provider.dart';
import 'package:petwise/data/providers/pet_user_provider.dart';
import 'package:petwise/data/providers/user_provider.dart';
import 'package:petwise/navigation/routing.dart';
import 'package:petwise/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';

class PetOwnerProfilePage extends StatefulWidget {
  const PetOwnerProfilePage({super.key});

  @override
  _PetOwnerProfilePageState createState() => _PetOwnerProfilePageState();
}

class _PetOwnerProfilePageState extends State<PetOwnerProfilePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final petProvider = Provider.of<PetProvider>(context, listen: false);
      final petUserProvider = Provider.of<PetUserProvider>(context, listen: false);

      // Make sure current user data is refreshed
      await userProvider.refreshCurrentUser();

      // Only load pet user if we have a current user
      if (userProvider.currentUser != null) {
        // Use the improved method that ensures a pet user exists
        final petUser = await petUserProvider.ensurePetUserExists(userProvider.currentUser!.id);
        if (petUser == null) {
          print("Warning: Failed to ensure pet user exists");
        }

        await petProvider.loadPets(userProvider.currentUser!.id);
      }
    } catch (e) {
      // Handle errors, maybe show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading profile data: $e')),
      );
      print("Profile error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Consumer3<UserProvider, PetUserProvider, PetProvider>(
              builder: (context, userProvider, petUserProvider, petProvider, _) {
                final user = userProvider.currentUser;
                final petUser = petUserProvider.currentPetUser;

                if (user == null) {
                  return const Center(child: Text('User not found', style: TextStyle(color: Colors.white)));
                }

                return Column(
                  children: [
                    ProfileHeader(petUser: petUser, user: user),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: petProvider.pets.isEmpty
                            ? ListView(
                                children: [
                                  const Center(child: Text('No pets added yet')),
                                  const AddPetButton(),
                                ],
                              )
                            : ListView(
                                children: [
                                  ...petProvider.pets.map((pet) => PetCard(pet: pet)),
                                  const AddPetButton(),
                                ],
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _loadData,
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.petUser, required this.user});

  final PetUser? petUser;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
              radius: 40, backgroundColor: Colors.purple[100], child: const Icon(Icons.person, size: 40, color: Colors.purple)),
          const SizedBox(height: 10),
          Text("${user.firstName} ${user.lastName}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(petUser?.homeAddress ?? 'No address set',
              textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 10),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () async {
              await context.pushNamed(AppRoute.editOwnerPage.name);
              // No need to manually refresh - we're using Consumer above
            },
          ),
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
        await context.pushNamed(AppRoute.editPetPage.name, extra: pet);
        // No need to handle the returned pet - the provider will update automatically
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
          subtitle: Text(
            "${pet.species} • ${pet.breed} • ${pet.age} years",
            style: TextStyle(color: Colors.grey[700]),
          ),
          trailing: const Icon(Icons.edit, size: 18),
        ),
      ),
    );
  }
}

class AddPetButton extends StatelessWidget {
  const AddPetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () async {
          final newPet = await context.pushNamed(
            AppRoute.editPetPage.name,
            extra: Pet(
              id: '',
              name: '',
              age: 0,
              weight: 0,
              species: '',
              breed: '',
              sex: 'Unknown',
              birthdate: DateTime.now(),
              color: '',
            ),
          );

          if (newPet != null && newPet is Pet) {
            await context.read<PetProvider>().createPet(newPet.toJson());
          }
        },
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text('Add Pet', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
