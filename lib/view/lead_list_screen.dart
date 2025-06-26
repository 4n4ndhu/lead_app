import 'package:flutter/material.dart';
import 'package:lead_app/model/leadmodel/lead.dart';
import 'package:provider/provider.dart';
import 'package:lead_app/controller/lead_list_controller.dart';

class LeadListScreen extends StatelessWidget {
  const LeadListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LeadListController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Lead List')),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          if (!controller.isLoading &&
              controller.hasMore &&
              scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
            controller.fetchLeads();
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () => controller.fetchLeads(refresh: true),
          child: controller.leads.isEmpty && !controller.isLoading
              ? const Center(
                  child: Text("No leads avialabe"),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount:
                      controller.leads.length + (controller.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < controller.leads.length) {
                      final lead = controller.leads[index];
                      return LeadCard(lead: lead);
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
        ),
      ),
    );
  }
}

class LeadCard extends StatelessWidget {
  final Lead lead;

  const LeadCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lead.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.email, size: 16),
                const SizedBox(width: 6),
                lead.email == null
                    ? Text("no email provided")
                    : Text(lead.email!),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: 6),
                Text(lead.phone),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                if (lead.course != null)
                  Chip(
                    label: Text('Course: ${lead.course!.name}'),
                    backgroundColor: Colors.blue.shade50,
                  ),
                if (lead.status != null)
                  Chip(
                    label: Text('Status: ${lead.status!.name}'),
                    backgroundColor: Colors.green.shade50,
                  ),
                if (lead.source != null)
                  Chip(
                    label: Text('Source: ${lead.source!.name}'),
                    backgroundColor: Colors.orange.shade50,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
