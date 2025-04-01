import 'package:pocketbase/pocketbase.dart';

class PetUserRepository {
  PetUserRepository._internal(this.pb);

  static PetUserRepository? _instance;
  static PetUserRepository getInstance(PocketBase pb) {
    _instance ??= PetUserRepository._internal(pb);
    return _instance!;
  }

  static PetUserRepository get instance => _instance!;

  final PocketBase pb;

  Future<Map<String, dynamic>> createPetUser(Map<String, dynamic> data) async {
    final record = await pb.collection('petUsers').create(body: data);
    return record.toJson();
  }

  Future<Map<String, dynamic>?> getPetUser(String userId) async {
    try {
      final result = await pb.collection('petUsers').getList(
            page: 1,
            perPage: 1,
            filter: 'user = "$userId"',
          );

      if (result.items.isEmpty) {
        print('No pet user found for userId: $userId');
        return null;
      }

      return result.items.first.toJson();
    } catch (e) {
      print('Error in getPetUser for userId $userId: $e');
      // Return null instead of rethrowing to allow for graceful handling
      return null;
    }
  }

  Future<bool> petUserExists(String userId) async {
    try {
      final result = await pb.collection('petUsers').getList(
            page: 1,
            perPage: 1,
            filter: 'user = "$userId"',
          );

      final exists = result.items.isNotEmpty;
      return exists;
    } catch (e) {
      print('Error checking if pet user exists for userId $userId: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> updatePetUser(String id, Map<String, dynamic> data) async {
    final record = await pb.collection('petUsers').update(id, body: data);
    return record.toJson();
  }

  Future<void> deletePetUser(String id) async {
    await pb.collection('petUsers').delete(id);
  }
}
