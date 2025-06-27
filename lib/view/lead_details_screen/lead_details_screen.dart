import 'package:flutter/material.dart';
import 'package:lead_app/model/leadmodel/lead.dart';

class LeadDetailsScreen extends StatelessWidget {
  final Lead lead;

  const LeadDetailsScreen({super.key, required this.lead});

  String _getValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Not Provided";
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lead Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailTile("Name", lead.name),
                const Divider(),
                _buildDetailTile("Email", _getValue(lead.email)),
                const Divider(),
                _buildDetailTile("Phone", _getValue(lead.phone)),
                const Divider(),
                _buildDetailTile(
                    "Qualification", _getValue(lead.qualification)),
                const Divider(),
                _buildDetailTile("Gender", _getValue(lead.gender)),
                const Divider(),
                if (lead.course != null)
                  _buildDetailTile("Course", _getValue(lead.course?.name)),
                if (lead.status != null)
                  _buildDetailTile("Status", _getValue(lead.status?.name)),
                if (lead.source != null)
                  _buildDetailTile("Source", _getValue(lead.source?.name)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
