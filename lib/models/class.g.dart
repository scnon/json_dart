//////////////////////////////////////////////
////         ____             __
////        / __ \____ ______/ /_
////       / / / / __ `/ ___/ __/
////      / /_/ / /_/ / /  / /_
////     /_____/\__,_/_/   \__/
////
////   CODE GENERATED DO NOT MODIFY !!!
////
//////////////////////////////////////////////

import 'user.g.dart';

class ClassModel {
  final List<UserModel> students;
  final double? score;
  final double? total;

  ClassModel({
    this.students = const [],
    this.score,
    this.total,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      students: json['students'] == null
          ? []
          : (json['students'] as List)
              .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      score: json['score'] as double?,
      total: json['total'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'students': students,
      'score': score,
      'total': total,
    };
  }
}
//////////////////////////////////////////////
////         ____             __
////        / __ \____ ______/ /_
////       / / / / __ `/ ___/ __/
////      / /_/ / /_/ / /  / /_
////     /_____/\__,_/_/   \__/
////
////   CODE GENERATED DO NOT MODIFY !!!
////
//////////////////////////////////////////////

class TeacherItemModel {
  final String name;
  final int id;
  final int? age;

  TeacherItemModel({
    required this.name,
    required this.id,
    this.age,
  });

  factory TeacherItemModel.fromJson(Map<String, dynamic> json) {
    return TeacherItemModel(
      name: json['name'] as String,
      id: json['id'] as int,
      age: json['age'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'age': age,
    };
  }
}
