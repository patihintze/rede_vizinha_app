import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String? email;
  final String? phone;
  final String? cep;
  final String? cpf;
  final Timestamp? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    this.email,
    this.phone,
    this.cep,
    this.cpf,
    this.createdAt,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic>? map) {
    map = map ?? {};
    return UserModel(
      uid: id,
      name: (map['name'] ?? '') as String,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      cep: map['cep'] as String?,
      cpf: map['cpf'] as String?,
      createdAt: map['createdAt'] as Timestamp?,
    );
  }
}
