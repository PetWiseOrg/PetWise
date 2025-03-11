class Pet {
  final String id;
  final String name;
  final String species;
  final String breed;
  final String sex;
  final DateTime birthdate;
  final String color;
  final String? chipNumber;
  final String? tagNumber;

  Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.sex,
    required this.birthdate,
    required this.color,
    this.chipNumber,
    this.tagNumber,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      species: json['species'] ?? '',
      breed: json['breed'] ?? '',
      sex: json['sex'] ?? '',
      birthdate: DateTime.parse(json['birthdate']),
      color: json['color'] ?? '',
      chipNumber: json['chipNumber'],
      tagNumber: json['tagNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'breed': breed,
      'sex': sex,
      'birthdate': birthdate.toIso8601String(),
      'color': color,
      'chipNumber': chipNumber,
      'tagNumber': tagNumber,
    };
  }
}
