import 'package:lead_app/model/leadmodel/lead.dart';

class LeadListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Lead> results;

  LeadListResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory LeadListResponse.fromJson(Map<String, dynamic> json) {
    return LeadListResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results:
          (json['results'] as List).map((item) => Lead.fromJson(item)).toList(),
    );
  }
}
