import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:lead_app/model/leadmodel/lead.dart';
import 'package:lead_app/service/api_service.dart';

class LeadListController with ChangeNotifier {
  final ApiService _api = ApiService();

  List<Lead> leads = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  bool isRefreshing = false;

  /// Initial fetch or pull-to-refresh
  Future<void> fetchLeads({bool refresh = false}) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    if (refresh) {
      leads.clear();
      currentPage = 1;
      hasMore = true;
      isRefreshing = true;
      notifyListeners();
    }

    try {
      final response = await _api.fetchLeads(page: currentPage);
      log("FETCHED ${response.results.length}leads from page $currentPage");
      leads.addAll(response.results);
      currentPage++;

      // If next is null, no more pages
      hasMore = response.next != null;
    } catch (e) {
      print('Lead fetch error: $e');
      // Optionally handle or store the error
    }

    isLoading = false;
    isRefreshing = false;
    notifyListeners();
  }

  void reset() {
    leads.clear();
    currentPage = 1;
    hasMore = true;
    isLoading = false;
    notifyListeners();
  }
}
