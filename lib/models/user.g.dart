////////////////////////////////////////////////////////////
////           ____             __
////          / __ \____ ______/ /_
////         / / / / __ `/ ___/ __/
////        / /_/ / /_/ / /  / /_
////       /_____/\__,_/_/   \__/
////
////   GENERATED CODE - DO NOT MODIFY BY HAND
////
////////////////////////////////////////////////////////////

class UserModel {
  final int id;
  final String name;
  final int age;
  final String? email;
  final List<int> numbers;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    this.email,
    this.numbers = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int,
      email: json['email'] as String?,
      numbers: json['numbers'] == null
          ? []
          : (json['numbers'] as List).map((e) => e as int).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'numbers': numbers,
    };
  }
}
