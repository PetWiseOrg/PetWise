import 'package:pocketbase/pocketbase.dart';

class PetRepository {
  PetRepository._internal(this.pb);

  static PetRepository? _instance;
  static PetRepository getInstance(PocketBase pb) {
    _instance ??= PetRepository._internal(pb);
    return _instance!;
  }

  static PetRepository get instance => _instance!;

  final PocketBase pb;

  Future<Map<String, dynamic>> createPet(Map<String, dynamic> data) async {
    final record = await pb.collection('pets').create(body: data);
    return record.toJson();
  }

  Future<Map<String, dynamic>> getPet(String id) async {
    final record = await pb.collection('pets').getOne(id);
    return record.toJson();
  }

  Future<List<Map<String, dynamic>>> getPetsByUser(String userId) async {
    try {
      final petUserResult = await pb.collection('petUsers').getList(
            filter: 'user = "$userId"',
            page: 1,
            perPage: 1,
          );

      if (petUserResult.items.isEmpty) {
        print('No petUser found for userId: $userId');
        return [];
      }

      // Get the petUser record and extract the pets relation
      final petUserRecord = petUserResult.items.first;
      final petIds = List<String>.from(petUserRecord.data['pets'] ?? []);
      
      if (petIds.isEmpty) {
        return [];
      }

      // Fetch each pet by ID
      final List<Map<String, dynamic>> results = [];
      for (final petId in petIds) {
        try {
          final petRecord = await pb.collection('pets').getOne(petId);
          results.add(petRecord.toJson());
        } catch (petError) {
          print('Error fetching pet with ID $petId: $petError');
          // Continue with other pets if one fails
        }
      }

      return results;
    } catch (e) {
      print('Error in getPetsByUser for userId $userId: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> updatePet(String id, Map<String, dynamic> data) async {
    final record = await pb.collection('pets').update(id, body: data);
    return record.toJson();
  }

  Future<void> deletePet(String id) async {
    await pb.collection('pets').delete(id);
  }
}
