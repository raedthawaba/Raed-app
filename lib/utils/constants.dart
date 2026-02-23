import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF009688);
  static const Color primaryDark = Color(0xFF00796B);
  static const Color primaryLight = Color(0xFF4DB6AC);
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color error = Color(0xFFE74C3C);
  static const Color success = Color(0xFF27AE60);
  static const Color divider = Color(0xFFDFE6E9);
  
  // Military theme colors
  static const Color militaryGreen = Color(0xFF2E5B4B);
  static const Color gold = Color(0xFFD4AF37);
}

class AppStrings {
  static const String appName = 'نظام إدارة الألوية';
  static const String welcomeBack = 'مرحباً بعودتك';
  static const String loginSubtitle = 'سجل دخولك للمتابعة';
  static const String email = 'البريد الإلكتروني';
  static const String password = 'كلمة المرور';
  static const String rememberMe = 'تذكرني';
  static const String login = 'تسجيل الدخول';
  static const String logout = 'تسجيل الخروج';
  static const String emailRequired = 'يرجى إدخال البريد الإلكتروني';
  static const String invalidEmail = 'صيغة البريد الإلكتروني غير صحيحة';
  static const String passwordRequired = 'يرجى إدخال كلمة المرور';
  static const String passwordTooShort = 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
  static const String loginSuccess = 'تم تسجيل الدخول بنجاح';
  static const String loginError = 'فشل تسجيل الدخول';
  static const String showPassword = 'إظهار كلمة المرور';
  static const String hidePassword = 'إخفاء كلمة المرور';
  
  // Home Screen
  static const String homeTitle = 'الرئيسية';
  static const String welcomeMessage = 'مرحباً بك';
  static const String selectSection = 'اختر القسم المطلوب';
  
  // Brigade Sections
  static const String brigadeSection1 = 'اللواء الأول';
  static const String brigadeSection2 = 'اللواء الثاني';
  static const String brigadeSection3 = 'اللواء الثالث';
  static const String brigadeSection4 = 'اللواء الرابع';
  static const String brigadeSection5 = 'اللواء الخامس';
  static const String brigadeSection6 = 'اللواء السادس';
  
  // All departments (same for all brigades)
  static const String department1 = 'البشرية';
  static const String department2 = 'التسليح';
  static const String department3 = 'الشؤون الإدارية';
  static const String department4 = 'الاستخبارات';
  static const String department5 = 'القسم الفني';
  static const String department6 = 'القسم الطبي';
  static const String department7 = 'الشرطة';
  static const String department8 = 'السيطرة';
  static const String department9 = 'الاشغال';
  static const String department10 = 'الرئاسة';
  static const String department11 = 'المالية';
  static const String department12 = 'الكتائب';
  static const String department13 = 'التوجيه المعنوي';
}

class AppDimensions {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  static const double borderRadius = 12.0;
  static const double buttonHeight = 56.0;
  static const double inputHeight = 56.0;
  static const double iconSize = 24.0;
}

// Brigade data model
class Brigade {
  final String name;
  final IconData icon;
  final Color color;
  
  const Brigade({
    required this.name,
    required this.icon,
    required this.color,
  });
}

// Department data model
class Department {
  final String name;
  final IconData icon;
  final Color color;
  
  const Department({
    required this.name,
    required this.icon,
    required this.color,
  });
}

// List of all brigades
class BrigadeData {
  static const List<Brigade> brigades = [
    Brigade(
      name: AppStrings.brigadeSection1,
      icon: Icons.shield,
      color: Color(0xFF1565C0),
    ),
    Brigade(
      name: AppStrings.brigadeSection2,
      icon: Icons.security,
      color: Color(0xFF2E7D32),
    ),
    Brigade(
      name: AppStrings.brigadeSection3,
      icon: Icons.group,
      color: Color(0xFFE65100),
    ),
    Brigade(
      name: AppStrings.brigadeSection4,
      icon: Icons.assignment,
      color: Color(0xFF6A1B9A),
    ),
    Brigade(
      name: AppStrings.brigadeSection5,
      icon: Icons.assessment,
      color: Color(0xFF00838F),
    ),
    Brigade(
      name: AppStrings.brigadeSection6,
      icon: Icons.military_tech,
      color: Color(0xFFC62828),
    ),
  ];
  
  // List of all departments (same for all brigades)
  static const List<Department> departments = [
    Department(
      name: AppStrings.department1,
      icon: Icons.people,
      color: Color(0xFF1565C0),
    ),
    Department(
      name: AppStrings.department2,
      icon: Icons.shield,
      color: Color(0xFF2E7D32),
    ),
    Department(
      name: AppStrings.department3,
      icon: Icons.folder,
      color: Color(0xFFE65100),
    ),
    Department(
      name: AppStrings.department4,
      icon: Icons.visibility,
      color: Color(0xFF6A1B9A),
    ),
    Department(
      name: AppStrings.department5,
      icon: Icons.build,
      color: Color(0xFF00838F),
    ),
    Department(
      name: AppStrings.department6,
      icon: Icons.local_hospital,
      color: Color(0xFFC62828),
    ),
    Department(
      name: AppStrings.department7,
      icon: Icons.local_police,
      color: Color(0xFF4527A0),
    ),
    Department(
      name: AppStrings.department8,
      icon: Icons.dashboard,
      color: Color(0xFF00897B),
    ),
    Department(
      name: AppStrings.department9,
      icon: Icons.construction,
      color: Color(0xFF5D4037),
    ),
    Department(
      name: AppStrings.department10,
      icon: Icons.star,
      color: Color(0xFFD4AF37),
    ),
    Department(
      name: AppStrings.department11,
      icon: Icons.attach_money,
      color: Color(0xFF0097A7),
    ),
    Department(
      name: AppStrings.department12,
      icon: Icons.flag,
      color: Color(0xFF1B5E20),
    ),
    Department(
      name: AppStrings.department13,
      icon: Icons.campaign,
      color: Color(0xFFE91E63),
    ),
  ];
}
