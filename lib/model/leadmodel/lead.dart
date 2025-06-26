import 'package:lead_app/model/leadmodel/course.dart';
import 'package:lead_app/model/leadmodel/source.dart';
import 'package:lead_app/model/leadmodel/status.dart';

class Lead {
  final String id;
  final String name;
  final String? email;
  final String phone;
  final String gender;
  final String qualification;
  final String address;
  final Course? course;
  final Status? status;
  final Source? source;

  Lead({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.qualification,
    required this.address,
    this.course,
    this.status,
    this.source,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json["phone_number"] ?? '',
      gender: json['gender'] ?? '',
      qualification: json['qualification'] ?? '',
      address: json['address'] ?? '',
      course: json['course'] != null ? Course.fromJson(json['course']) : null,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      source: json['source'] != null ? Source.fromJson(json['source']) : null,
    );
  }
}
