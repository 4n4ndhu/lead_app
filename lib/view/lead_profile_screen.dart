import 'package:flutter/material.dart';
import 'package:lead_app/model/profile_model/user_model.dart';
import 'package:lead_app/service/api_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: FutureBuilder<UserModel>(
        future: ApiService().fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No user data found."));
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12)),
                      height: 150,
                      width: 150,
                      child: Icon(Icons.person),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Full Name: ${user.fullName}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Email: ${user.email}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Phone: ${user.phone}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "WhatsApp: ${user.whatsapp}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Role: ${user.roleLabel} (${user.roleValue})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )

                //   Text("Full Name: ${user.fullName}"),
                //   Text("Email: ${user.email}"),
                //   Text("Phone: ${user.phone}"),
                //   Text("WhatsApp: ${user.whatsapp}"),
                //   Text("Role: ${user.roleLabel} (${user.roleValue})"),
              ],
            ),
          );
        },
      ),
    );
  }
}
