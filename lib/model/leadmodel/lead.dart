// import 'package:lead_app/model/leadmodel/course.dart';
// import 'package:lead_app/model/leadmodel/source.dart';
// import 'package:lead_app/model/leadmodel/status.dart';

// class Lead {
//   final String id;
//   final String name;
//   final String? email;
//   final String phone;
//   final String gender;
//   final String qualification;
//   final String address;
//   final Course? course;
//   final Status? status;
//   final Source? source;

//   Lead({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.gender,
//     required this.qualification,
//     required this.address,
//     this.course,
//     this.status,
//     this.source,
//   });

//   factory Lead.fromJson(Map<String, dynamic> json) {
//     return Lead(
//       id: json['id'],
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       phone: json["phone_number"] ?? '',
//       gender: json['gender'] ?? '',
//       qualification: json['qualification'] ?? '',
//       address: json['address'] ?? '',
//       course: json['course'] != null ? Course.fromJson(json['course']) : null,
//       status: json['status'] != null ? Status.fromJson(json['status']) : null,
//       source: json['source'] != null ? Source.fromJson(json['source']) : null,
//     );
//   }
// }

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
      course: _parseCourse(json['course']),
      status: _parseStatus(json['status']),
      source: _parseSource(json['source']),
    );
  }

  // Helper method to parse course - handles both int and Map
  static Course? _parseCourse(dynamic courseData) {
    if (courseData == null) return null;

    if (courseData is Map<String, dynamic>) {
      return Course.fromJson(courseData);
    } else if (courseData is int) {
      // If it's just an ID, create a Course with that ID and empty name
      return Course(id: courseData, name: '');
    }

    return null;
  }

  // Helper method to parse status - handles both int and Map
  static Status? _parseStatus(dynamic statusData) {
    if (statusData == null) return null;

    if (statusData is Map<String, dynamic>) {
      return Status.fromJson(statusData);
    } else if (statusData is int) {
      // If it's just an ID, create a Status with that ID and empty name
      return Status(id: statusData, name: '');
    }

    return null;
  }

  // Helper method to parse source - handles both int and Map
  static Source? _parseSource(dynamic sourceData) {
    if (sourceData == null) return null;

    if (sourceData is Map<String, dynamic>) {
      return Source.fromJson(sourceData);
    } else if (sourceData is int) {
      // If it's just an ID, create a Source with that ID and empty name
      return Source(id: sourceData, name: '');
    }

    return null;
  }
}
