import 'package:flutter/material.dart';

class SettingsService with ChangeNotifier {
  bool _isDarkMode = false;
  double _monthlyBudget = 10000.0;

  bool get isDarkMode => _isDarkMode;
  double get monthlyBudget => _monthlyBudget;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updateMonthlyBudget(double budget) {
    _monthlyBudget = budget;
    notifyListeners();
  }
}