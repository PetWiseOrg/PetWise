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

  Future<Map<String, dynamic>> getPetUser(String userId) async {
    final record = await pb.collection('petUsers').getFirstListItem('user="$userId"');
    return record.toJson();
  }

  Future<Map<String, dynamic>> updatePetUser(String id, Map<String, dynamic> data) async {
    final record = await pb.collection('petUsers').update(id, body: data);
    return record.toJson();
  }

  Future<void> deletePetUser(String id) async {
    await pb.collection('petUsers').delete(id);
  }
}
