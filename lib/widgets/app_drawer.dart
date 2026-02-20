import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../screens/settings_screen.dart';
import '../screens/rating_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/changelog_screen.dart';
import '../screens/about_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.primary,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: AppDimensions.paddingMedium),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    children: [
                      const SizedBox(height: AppDimensions.paddingMedium),
                      _buildMenuItem(
                        context,
                        'إعدادات التطبيق',
                        Icons.settings,
                        0xFF1565C0,
                        () => _navigateTo(context, const SettingsScreen()),
                      ),
                      _buildMenuItem(
                        context,
                        'قيّم التطبيق',
                        Icons.star,
                        0xFFFFD700,
                        () => _navigateTo(context, const RatingScreen()),
                      ),
                      _buildMenuItem(
                        context,
                        'تواصل معنا',
                        Icons.email,
                        0xFF2E7D32,
                        () => _navigateTo(context, const ContactScreen()),
                      ),
                      _buildMenuItem(
                        context,
                        'سجل التحديثات',
                        Icons.history,
                        0xFFE65100,
                        () => _navigateTo(context, const ChangelogScreen()),
                      ),
                      _buildMenuItem(
                        context,
                        'حول التطبيق',
                        Icons.info,
                        0xFF6A1B9A,
                        () => _navigateTo(context, const AboutScreen()),
                      ),
                      const SizedBox(height: AppDimensions.paddingLarge),
                      _buildMenuItem(
                        context,
                        'تسجيل الخروج',
                        Icons.logout,
                        0xFFE74C3C,
                        () => _showLogoutDialog(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.admin_panel_settings,
              color: AppColors.primary,
              size: 35,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مسؤول النظام',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'admin@gmail.com',
                  style: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingMedium,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Color(color), size: 22),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('تسجيل الخروج', style: GoogleFonts.tajawal(fontWeight: FontWeight.bold)),
        content: Text('هل أنت متأكد من تسجيل الخروج؟', style: GoogleFonts.tajawal()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء', style: GoogleFonts.tajawal(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text('تسجيل الخروج', style: GoogleFonts.tajawal()),
          ),
        ],
      ),
    );
  }
}
