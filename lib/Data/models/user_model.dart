import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/Data/models/project_model.dart';
import 'package:travel_app/Data/models/task_model.dart';

class UserModal {
  UserModal({
    this.id,
    this.name,
    this.birthday,
    this.address,
    this.idNumber,
    this.position,
    this.email,
    this.phoneNumber,
    this.userName,
    this.password,
    this.projects,
    this.tasks,
    this.checkIn,
    this.createAt,
    this.updateAt,
  });

  final String? name;
  final String? userName;
  final String? password;
  final String? id;
  final DateTime? birthday;
  final String? address;
  final String? idNumber;
  final String? phoneNumber;
  final String? position;
  final String? email;
  final List? checkIn;
  final List? projects;
  final List? tasks;
  final DateTime? createAt;
  final DateTime? updateAt;

  static UserModal fromJson(Map<String, dynamic> json) => UserModal(
        id: json["id"],
        name: json['name'],
        userName: json['userName'],
        password: json['password'],
        birthday: (json['birthday'] as Timestamp).toDate(),
        address: json['address'],
        idNumber: json['idNumber'],
        phoneNumber: json['phoneNumber'],
        position: json['position'],
        email: json['email'],
        checkIn: (json['checkIn'] ?? [] as List).toList(),
        projects: (json['projects'] ?? [] as List).toList(),
        tasks: (json['tasks'] ?? [] as List).toList(),
        createAt: (json['createAt'] as Timestamp).toDate(),
        updateAt: (json['updateAt'] as Timestamp).toDate(),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userName": userName,
        "password": password,
        "birthday": birthday,
        "address": address,
        "idNumber": idNumber,
        "phoneNumber": phoneNumber,
        "position": position,
        "email": email,
        "checkIn": checkIn,
        "projects": projects,
        "tasks": tasks,
        "createAt": createAt,
        "updateAt": updateAt,
      };
}
