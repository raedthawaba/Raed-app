import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  
  // Keys for SharedPreferences
  static const String _adminEmailKey = 'admin_email';
  static const String _adminPasswordKey = 'admin_password';
  
  // Default admin credentials
  static const String _defaultEmail = 'admin@gmail.com';
  static const String _defaultPassword = 'admin123';

  DatabaseHelper._init();

  // Get current admin email
  Future<String> getAdminEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_adminEmailKey) ?? _defaultEmail;
  }

  // Get current admin password
  Future<String> getAdminPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_adminPasswordKey) ?? _defaultPassword;
  }

  // Authenticate admin user
  Future<bool> authenticateAdmin(String email, String password) async {
    final currentEmail = await getAdminEmail();
    final currentPassword = await getAdminPassword();
    
    return email == currentEmail && password == currentPassword;
  }

  // Update admin credentials
  Future<bool> updateAdminCredentials({
    required String currentPassword,
    required String newEmail,
    required String newPassword,
  }) async {
    final storedPassword = await getAdminPassword();
    
    // Verify current password
    if (currentPassword != storedPassword) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_adminEmailKey, newEmail);
    await prefs.setString(_adminPasswordKey, newPassword);
    return true;
  }

  // Reset to default admin
  Future<void> resetToDefault() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_adminEmailKey);
    await prefs.remove(_adminPasswordKey);
  }
}
