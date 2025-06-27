import 'package:flutter/material.dart';
import 'package:lead_app/controller/lead_controller/lead_list_controller.dart';
import 'package:lead_app/controller/login_controller/login_screen_controller.dart';
import 'package:lead_app/view/bottom_nav_screen/bottom_navigationbar.dart';

import 'package:lead_app/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LeadListController()..fetchLeads(),
        )
      ],
      child: MaterialApp(
        home: isLoggedIn ? const BottomNavScreen() : const LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
