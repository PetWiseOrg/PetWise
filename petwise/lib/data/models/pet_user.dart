class PetUser {
  final String id;
  final String userId;
  final String homeAddress;
  final Map<String, dynamic>? preferences;
  final List<String> petIds;

  PetUser({
    required this.id,
    required this.userId,
    required this.homeAddress,
    this.preferences,
    this.petIds = const [],
  });

  factory PetUser.fromJson(Map<String, dynamic> json) {
    return PetUser(
      id: json['id'] ?? '',
      userId: json['user'] ?? '',
      homeAddress: json['homeAddress'] ?? '',
      preferences: json['preferences'],
      petIds: List<String>.from(json['pets'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'homeAddress': homeAddress,
      'preferences': preferences,
      'pets': petIds,
    };
  }
}
