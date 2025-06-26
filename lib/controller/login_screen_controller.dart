import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lead_app/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return false;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final email = loginEmailController.text.trim();
    final password = loginPassController.text.trim();

    try {
      final response = await ApiService().loginUser(email, password);

      final token = response['access']; // collect access token

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await prefs.setString('token', token); // Save token
      log("YOUR TOKEN : $token");
      await prefs.setBool('isLoggedIn', true); // Save login state

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Optional helper method to clear data on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // clear all saved values
  }
}
