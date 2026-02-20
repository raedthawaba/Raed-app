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
  static const String brigadeSection1 = 'قسم اللواء الأول';
  static const String brigadeSection2 = 'قسم اللواء الثاني';
  static const String brigadeSection3 = 'قسم اللواء الثالث';
  static const String brigadeSection4 = 'قسم اللواء الرابع';
  static const String brigadeSection5 = 'قسم اللواء الخامس';
  static const String brigadeSection6 = 'قسم اللواء السادس';
  
  // Brigade Section 1 Sub-sections
  static const String brigade1Section1 = 'قسم البشرية';
  static const String brigade1Section2 = 'قسم التسليح';
  static const String brigade1Section3 = 'قسم الشؤون الإدارية';
  static const String brigade1Section4 = 'قسم الاستخبارات';
  static const String brigade1Section5 = 'القسم الفني';
  static const String brigade1Section6 = 'القسم الطبي';
  static const String brigade1Section7 = 'قسم الشرطة';
  static const String brigade1Section8 = 'قسم السيطرة';
  static const String brigade1Section9 = 'قسم الأشغال';
  static const String brigade1Section10 = 'قسم رئاسة';
  static const String brigade1Section11 = 'قسم الكتائب';
  static const String brigade1Section12 = 'قسم التوجيه المعنوي';
  static const String brigade1Section13 = 'قسم المالية';
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
