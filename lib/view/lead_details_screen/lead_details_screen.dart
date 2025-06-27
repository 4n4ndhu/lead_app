import 'package:flutter/material.dart';
import 'package:lead_app/model/leadmodel/lead.dart';

class LeadDetailsScreen extends StatelessWidget {
  final Lead lead;

  const LeadDetailsScreen({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name: ${lead.name}"),
            lead.email == ""
                ? Text("No Email Provided")
                : lead.email == null
                    ? Text("no email")
                    : Text("${lead.email}"),
            // : Text("Email: ${lead.email}"),
            Text("Phone: ${lead.phone}"),
            Text("qualification: ${lead.qualification}"),
            Text("Gender: ${lead.gender}"),
          ],
        ),
      ),
    );
  }
}
