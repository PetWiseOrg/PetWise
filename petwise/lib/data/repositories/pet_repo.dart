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
    final records = await pb.collection('pets').getList(filter: 'owner="$userId"');
    return records.items.map((record) => record.toJson()).toList();
  }

  Future<Map<String, dynamic>> updatePet(String id, Map<String, dynamic> data) async {
    final record = await pb.collection('pets').update(id, body: data);
    return record.toJson();
  }

  Future<void> deletePet(String id) async {
    await pb.collection('pets').delete(id);
  }
}
