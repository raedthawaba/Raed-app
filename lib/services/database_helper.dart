import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  
  // In-memory storage for web platform
  static Map<String, Map<String, dynamic>>? _inMemoryDb;
  
  // Default admin credentials
  static const String _defaultEmail = 'admin@gmail.com';
  static const String _defaultPassword = 'admin123';

  DatabaseHelper._init();

  // Initialize database (works on all platforms)
  Future<void> initDatabase() async {
    if (kIsWeb) {
      // For web, use shared preferences
      final prefs = await SharedPreferences.getInstance();
      final dbString = prefs.getString('app_database');
      
      if (dbString == null) {
        // Initialize with default admin
        _inMemoryDb = {
          'admin_users': {
            '1': {
              'id': 1,
              'email': _defaultEmail,
              'password': _defaultPassword,
              'created_at': DateTime.now().toIso8601String(),
            }
          }
        };
        await _saveToPrefs();
      } else {
        _inMemoryDb = Map<String, Map<String, dynamic>>.from(
          json.decode(dbString).map(
            (key, value) => MapEntry(key, Map<String, dynamic>.from(value)),
          ),
        );
      }
    }
  }

  Future<void> _saveToPrefs() async {
    if (kIsWeb && _inMemoryDb != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('app_database', json.encode(_inMemoryDb));
    }
  }

  // Authenticate admin user
  Future<bool> authenticateAdmin(String email, String password) async {
    await initDatabase();
    
    if (kIsWeb) {
      final users = _inMemoryDb?['admin_users'];
      if (users != null) {
        for (var user in users.values) {
          if (user['email'] == email && user['password'] == password) {
            return true;
          }
        }
      }
      return false;
    }
    
    // For non-web platforms, use simple in-memory check
    return email == _defaultEmail && password == _defaultPassword;
  }

  // Update admin credentials
  Future<bool> updateAdminCredentials({
    required String currentEmail,
    required String currentPassword,
    required String newEmail,
    required String newPassword,
  }) async {
    await initDatabase();
    
    // Verify current credentials
    final isValid = await authenticateAdmin(currentEmail, currentPassword);
    if (!isValid) {
      return false;
    }

    if (kIsWeb && _inMemoryDb != null) {
      final users = _inMemoryDb!['admin_users'];
      if (users != null) {
        for (var entry in users.entries) {
          if (entry.value['email'] == currentEmail) {
            entry.value['email'] = newEmail;
            entry.value['password'] = newPassword;
            await _saveToPrefs();
            return true;
          }
        }
      }
    }
    
    return false;
  }

  // Get admin info
  Future<Map<String, dynamic>?> getAdminInfo(String email) async {
    await initDatabase();
    
    if (kIsWeb && _inMemoryDb != null) {
      final users = _inMemoryDb?['admin_users'];
      if (users != null) {
        for (var user in users.values) {
          if (user['email'] == email) {
            return {
              'id': user['id'],
              'email': user['email'],
              'created_at': user['created_at'],
            };
          }
        }
      }
    }
    return null;
  }

  // Check if admin exists
  Future<bool> adminExists() async {
    await initDatabase();
    
    if (kIsWeb) {
      return _inMemoryDb?['admin_users']?.isNotEmpty ?? false;
    }
    return true;
  }

  // Reset to default admin
  Future<void> resetToDefault() async {
    if (kIsWeb) {
      _inMemoryDb = {
        'admin_users': {
          '1': {
            'id': 1,
            'email': _defaultEmail,
            'password': _defaultPassword,
            'created_at': DateTime.now().toIso8601String(),
          }
        }
      };
      await _saveToPrefs();
    }
  }
}
