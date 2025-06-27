import 'package:flutter/rendering.dart';

class UserModel {
  final int id;
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String whatsapp;
  final String roleLabel;
  final String roleValue;
  final String gender;
  final String qualification;
  final String address;

  UserModel(
      {required this.id,
      required this.uid,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.whatsapp,
      required this.roleLabel,
      required this.roleValue,
      required this.address,
      required this.gender,
      required this.qualification});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      uid: json['uid'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      whatsapp: json['whatsapp_number'],
      roleLabel: json['role_details']['label'] ?? '',
      roleValue: json['role_details']['value'] ?? '',
      gender: json['gender'] ?? '',
      qualification: json['qualification'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
