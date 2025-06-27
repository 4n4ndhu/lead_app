import 'package:flutter/material.dart';
import 'package:lead_app/model/leadmodel/lead.dart';
import 'package:lead_app/view/lead_details_screen/lead_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:lead_app/controller/lead_controller/lead_list_controller.dart';

class LeadListScreen extends StatefulWidget {
  const LeadListScreen({super.key});

  @override
  State<LeadListScreen> createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    final controller = context.read<LeadListController>();
    _searchController = TextEditingController(text: controller.searchQuery);
    _searchController.addListener(() {
      setState(() {}); // rebuild to reflect suffix icon changes
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LeadListController>();
    // final Textcontroller = TextEditingController(text: controller.searchQuery);

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
              ? SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            controller.updateSearchQuery(value.trim());
                          },
                          decoration: InputDecoration(
                              hintText: "Search leads",
                              hintStyle: TextStyle(color: Colors.grey),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    _searchController.clear();
                                    controller.updateSearchQuery('');
                                    FocusScope.of(context).unfocus();
                                  },
                                  icon: Icon(Icons.clear)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        const Center(
                          child: Text("No leads avialabe"),
                        )
                      ])))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            controller.updateSearchQuery(value.trim());
                          },
                          decoration: InputDecoration(
                              hintText: "Search leads",
                              hintStyle: TextStyle(color: Colors.grey),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    _searchController.clear();
                                    controller.updateSearchQuery('');
                                  },
                                  icon: Icon(Icons.clear)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: List.generate(
                            controller.leads.length +
                                (controller.hasMore ? 1 : 0),
                            (index) {
                              if (index < controller.leads.length) {
                                final lead = controller.leads[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LeadDetailsScreen(lead: lead),
                                        ));
                                  },
                                  child: LeadCard(lead: lead),
                                );
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
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
                lead.email == ""
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
