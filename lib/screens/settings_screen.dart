import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../widgets/custom_text_field.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Account settings
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // App settings
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  String _language = 'العربية';
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadSettings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
        _darkModeEnabled = prefs.getBool('dark_mode_enabled') ?? false;
        _soundEnabled = prefs.getBool('sound_enabled') ?? true;
        _vibrationEnabled = prefs.getBool('vibration_enabled') ?? true;
        _language = prefs.getString('language') ?? 'العربية';
      });
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notifications_enabled', _notificationsEnabled);
      await prefs.setBool('dark_mode_enabled', _darkModeEnabled);
      await prefs.setBool('sound_enabled', _soundEnabled);
      await prefs.setBool('vibration_enabled', _vibrationEnabled);
      await prefs.setString('language', _language);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم حفظ الإعدادات بنجاح',
              style: GoogleFonts.tajawal(),
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error saving settings: $e');
    }
  }

  Future<void> _changePassword() async {
    if (_currentPasswordController.text.isEmpty || 
        _newPasswordController.text.isEmpty || 
        _confirmPasswordController.text.isEmpty) {
      _showError('يرجى ملء جميع الحقول');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String storedPassword = prefs.getString('admin_password') ?? 'admin123';
    
    if (_currentPasswordController.text != storedPassword) {
      _showError('كلمة المرور الحالية غير صحيحة');
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showError('كلمات المرور غير متطابقة');
      return;
    }

    if (_newPasswordController.text.length < 6) {
      _showError('كلمة المرور يجب أن تكون 6 أحرف على الأقل');
      return;
    }

    await prefs.setString('admin_password', _newPasswordController.text);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم تغيير كلمة المرور بنجاح',
            style: GoogleFonts.tajawal(),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.tajawal()),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'الإعدادات',
          style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.tajawal(),
          tabs: const [
            Tab(text: 'الحساب'),
            Tab(text: 'التطبيق'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAccountSettings(),
          _buildAppSettings(),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('إعدادات الحساب', Icons.person),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildInfoCard(
            children: [
              _buildInfoRow('البريد الإلكتروني', 'admin@gmail.com', Icons.email),
              const Divider(),
              _buildInfoRow('نوع الحساب', 'مسؤول النظام', Icons.admin_panel_settings),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildSectionHeader('تغيير كلمة المرور', Icons.lock),
          const SizedBox(height: AppDimensions.paddingMedium),
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                CustomTextField(
                  controller: _currentPasswordController,
                  labelText: 'كلمة المرور الحالية',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                CustomTextField(
                  controller: _newPasswordController,
                  labelText: 'كلمة المرور الجديدة',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                CustomTextField(
                  controller: _confirmPasswordController,
                  labelText: 'تأكيد كلمة المرور',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: AppDimensions.paddingLarge),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _changePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: Text(
                      'تغيير كلمة المرور',
                      style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('الإشعارات', Icons.notifications),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildSettingsCard(
            children: [
              _buildSwitchTile(
                'الإشعارات',
                'تفعيل أو إيقاف الإشعارات',
                _notificationsEnabled,
                (value) => setState(() => _notificationsEnabled = value),
                Icons.notifications_active,
              ),
              const Divider(),
              _buildSwitchTile(
                'الصوت',
                'تشغيل الأصوات',
                _soundEnabled,
                (value) => setState(() => _soundEnabled = value),
                Icons.volume_up,
              ),
              const Divider(),
              _buildSwitchTile(
                'الاهتزاز',
                'تفعيل الاهتزاز',
                _vibrationEnabled,
                (value) => setState(() => _vibrationEnabled = value),
                Icons.vibration,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildSectionHeader('المظهر', Icons.palette),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildSettingsCard(
            children: [
              _buildSwitchTile(
                'الوضع الداكن',
                'تفعيل الوضع الداكن',
                _darkModeEnabled,
                (value) => setState(() => _darkModeEnabled = value),
                Icons.dark_mode,
              ),
              const Divider(),
              _buildListTile(
                'اللغة',
                _language,
                Icons.language,
                () => _showLanguageDialog(),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildSectionHeader('حول التطبيق', Icons.info),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildSettingsCard(
            children: [
              _buildInfoRow('الإصدار', '1.0.0', Icons.info_outline),
              const Divider(),
              _buildInfoRow('تاريخ الإصدار', '21 فبراير 2026', Icons.calendar_today),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingLarge * 2),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                'حفظ الإعدادات',
                style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.tajawal(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.tajawal(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.tajawal(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, String value, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 12),
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
            Text(
              value,
              style: GoogleFonts.tajawal(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_back_ios, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('اختر اللغة', style: GoogleFonts.tajawal(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('العربية', 'العربية'),
            _buildLanguageOption('English', 'الإنجليزية'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String title, String subtitle) {
    return ListTile(
      title: Text(title, style: GoogleFonts.tajawal()),
      subtitle: Text(subtitle, style: GoogleFonts.tajawal()),
      trailing: _language == title ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: () {
        setState(() {
          _language = title;
        });
        Navigator.pop(context);
      },
    );
  }
}
