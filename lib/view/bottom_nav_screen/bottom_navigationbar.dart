import 'package:flutter/material.dart';
import 'package:lead_app/controller/lead_controller/lead_list_controller.dart';
import 'package:lead_app/view/lead_list_screen/lead_list_screen.dart';
import 'package:lead_app/view/profile_screen/lead_profile_screen.dart';
import 'package:provider/provider.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  List screens = [LeadListScreen(), ProfilePage()];
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selected],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          // backgroundColor: Colors.black,
          currentIndex: selected,
          onTap: (value) {
            selected = value;

            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                ),
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                activeIcon: Icon(
                  Icons.person_outline,
                ),
                label: "Profile"),
          ]),
    );
  }
}
