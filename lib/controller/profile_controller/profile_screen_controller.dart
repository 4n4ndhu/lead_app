import 'package:flutter/material.dart';
import 'package:lead_app/model/profile_model/user_model.dart';
import 'package:lead_app/service/api_service.dart';

class ProfileController with ChangeNotifier {
  final ApiService _apiService = ApiService();
  UserModel? user;
  bool isLoading = false;
  String? error;

  Future<void> fetchUser() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      user = await _apiService.fetchUserProfile();
      await _apiService.fetchUserProfile();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      user = await _apiService.updateUserProfile(data);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
