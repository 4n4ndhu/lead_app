import 'package:flutter/material.dart';
import 'package:lead_app/controller/login_controller/login_screen_controller.dart';
import 'package:lead_app/controller/profile_controller/profile_screen_controller.dart';
import 'package:lead_app/view/edit_profile_screen/edit_profie_screen.dart';
import 'package:lead_app/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginScreenController>();
    final provider2 = context.watch<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                provider.logout();
                provider.loginEmailController.clear();
                provider.loginPassController.clear();
                Provider.of<ProfileController>(context, listen: false)
                    .clearUser();
                // provider2.clearUser();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Consumer<ProfileController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = controller.user;

          if (user == null) {
            return const Center(child: Text("No user data found."));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12)),
                  height: 150,
                  width: 150,
                  child: const Icon(Icons.person, size: 100),
                ),
                const SizedBox(height: 20),
                _profileRow("NAME", user.fullName.toUpperCase()),
                _profileRow("ROLE", user.roleLabel),
                _profileRow("EMAIL", user.email),
                _profileRow("PHONE",
                    user.phone.isEmpty ? "No phone number" : user.phone),
                _profileRow("WHATSAPP", user.whatsapp),
                _profileRow("GENDER",
                    user.gender.isEmpty ? "Not Specified" : user.gender),
                _profileRow(
                    "QUALIFICATION",
                    user.qualification.isEmpty
                        ? "Not Specified"
                        : user.qualification),
                _profileRow("ADDRESS",
                    user.address.isEmpty ? "Not Provided" : user.address),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
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
