import 'package:flutter/material.dart';
import 'package:lead_app/controller/profile_controller/profile_screen_controller.dart';
import 'package:lead_app/service/api_service.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ApiService _apiService = ApiService();

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileController>().user;

    _controllers['full_name'] =
        TextEditingController(text: user?.fullName ?? '');
    _controllers['phone'] = TextEditingController(text: user?.phone ?? '');
    _controllers['whatsapp_number'] =
        TextEditingController(text: user?.whatsapp ?? '');
    _controllers['gender'] = TextEditingController(text: user?.gender ?? '');
    _controllers['qualification'] =
        TextEditingController(text: user?.qualification ?? '');
    _controllers['address'] = TextEditingController(text: user?.address ?? '');
  }

  @override
  void dispose() {
    _controllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'full_name': _controllers['full_name']!.text.trim(),
        'phone': _controllers['phone']!.text.trim(),
        'whatsapp_number': _controllers['whatsapp_number']!.text.trim(),
        'gender': _controllers['gender']!.text.trim(),
        'qualification': _controllers['qualification']!.text.trim(),
        'address': _controllers['address']!.text.trim(),
      };

      await context.read<ProfileController>().updateUser(data);
      // _apiService.fetchUserProfile();

      final error = context.read<ProfileController>().error;
      // _apiService.fetchUserProfile();

      if (error == null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );
        Navigator.pop(context); // Go back to profile screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? "Unknown error")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    ..._controllers.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: TextFormField(
                          controller: entry.value,
                          decoration: InputDecoration(
                            labelText:
                                entry.key.replaceAll('_', ' ').toUpperCase(),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      );
                    }),
                    ElevatedButton(
                      onPressed: _save,
                      child: const Text("Save Changes"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
