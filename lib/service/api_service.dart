import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lead_app/model/leadmodel/lead_list_response.dart';
import 'package:lead_app/model/profile_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'https://api.crm.luminartechnohub.com/api';
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    const url = '$_baseUrl/auth/login/';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200 && data.containsKey('access')) {
      return data;
    } else {
      throw Exception(
          data['detail'] ?? 'Login failed invalid email or password');
    }
  }

  Future<LeadListResponse> fetchLeads({int page = 1}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    log('USING TOKEN: $token');

    final response = await http.get(
      Uri.parse('$_baseUrl/leads/?page=$page'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );
    log("API RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {
      return LeadListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch leads');
    }
  }

  Future<UserModel> fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await http.get(
      Uri.parse('$_baseUrl/profile/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data['user']);
    } else {
      throw Exception('Failed to load user profile: ${response.statusCode}');
    }
  }
}
