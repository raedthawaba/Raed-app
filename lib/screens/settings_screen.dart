import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../widgets/custom_text_field.dart';
import '../services/database_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Account settings
  final _currentEmailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newEmailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // App settings - using in-memory state
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  String _language = 'العربية';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAdminInfo();
  }

  Future<void> _loadAdminInfo() async {
    final email = await DatabaseHelper.instance.getAdminEmail();
    setState(() {
      _currentEmailController.text = email;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _currentEmailController.dispose();
    _currentPasswordController.dispose();
    _newEmailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, Color backgroundColor) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: GoogleFonts.tajawal()),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _updateCredentials() async {
    final currentPassword = _currentPasswordController.text.trim();
    final newEmail = _newEmailController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (currentPassword.isEmpty || newEmail.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar('الرجاء ملء جميع الحقول', AppColors.error);
      return;
    }

    if (newPassword != confirmPassword) {
      _showSnackBar('كلمات المرور الجديدة غير متطابقة', AppColors.error);
      return;
    }

    if (newPassword.length < 6) {
      _showSnackBar('كلمة المرور الجديدة يجب أن تكون 6 أحرف على الأقل', AppColors.error);
      return;
    }

    // Validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(newEmail)) {
      _showSnackBar('صيغة البريد الإلكتروني غير صحيحة', AppColors.error);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final success = await DatabaseHelper.instance.updateAdminCredentials(
        currentPassword: currentPassword,
        newEmail: newEmail,
        newPassword: newPassword,
      );

      if (success) {
        _showSnackBar('تم تحديث البيانات بنجاح. يرجى إعادة تسجيل الدخول.', AppColors.success);
        
        // Clear the form
        _currentPasswordController.clear();
        _newEmailController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
        
        // Navigate to login after a short delay
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        }
      } else {
        _showSnackBar('كلمة المرور الحالية غير صحيحة', AppColors.error);
      }
    } catch (e) {
      _showSnackBar('حدث خطأ: $e', AppColors.error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'الحساب', icon: Icon(Icons.person)),
            Tab(text: 'التطبيق', icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAccountTab(),
          _buildAppTab(),
        ],
      ),
    );
  }

  Widget _buildAccountTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('معلومات الحساب', Icons.person),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _currentEmailController,
            labelText: 'البريد الإلكتروني الحالي',
            prefixIcon: Icons.email,
            enabled: false,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('تغيير بيانات المسؤول', Icons.admin_panel_settings),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'أدخل كلمة المرور الحالية لتغيير البريد الإلكتروني أو كلمة المرور',
                    style: GoogleFonts.tajawal(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _currentPasswordController,
            labelText: 'كلمة المرور الحالية',
            prefixIcon: Icons.lock,
            obscureText: true,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: _newEmailController,
            labelText: 'البريد الإلكتروني الجديد',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: _newPasswordController,
            labelText: 'كلمة المرور الجديدة',
            prefixIcon: Icons.lock,
            obscureText: true,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: _confirmPasswordController,
            labelText: 'تأكيد كلمة المرور الجديدة',
            prefixIcon: Icons.lock,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _updateCredentials,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'حفظ التغييرات',
                      style: GoogleFonts.tajawal(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('الإشعارات', Icons.notifications),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'تفعيل الإشعارات',
            subtitle: 'استقبال الإشعارات الجديدة',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            icon: Icons.notifications_active,
          ),
          const Divider(height: 32),
          _buildSectionHeader('المظهر', Icons.palette),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'الوضع الداكن',
            subtitle: 'تغيير لون التطبيق إلى الداكن',
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
            icon: Icons.dark_mode,
          ),
          const Divider(height: 32),
          _buildSectionHeader('الصوت والاهتزاز', Icons.volume_up),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'تفعيل الصوت',
            subtitle: 'أصوات التطبيق',
            value: _soundEnabled,
            onChanged: (value) {
              setState(() {
                _soundEnabled = value;
              });
            },
            icon: Icons.volume_up,
          ),
          _buildSwitchTile(
            title: 'تفعيل الاهتزاز',
            subtitle: 'اهتزاز الجهاز عند التنبيهات',
            value: _vibrationEnabled,
            onChanged: (value) {
              setState(() {
                _vibrationEnabled = value;
              });
            },
            icon: Icons.vibration,
          ),
          const Divider(height: 32),
          _buildSectionHeader('اللغة', Icons.language),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.language, color: AppColors.primary),
            title: Text('لغة التطبيق', style: GoogleFonts.tajawal()),
            subtitle: Text(_language, style: GoogleFonts.tajawal(color: AppColors.textSecondary)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Show language picker
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
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

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: AppColors.primary),
      title: Text(title, style: GoogleFonts.tajawal()),
      subtitle: Text(subtitle, style: GoogleFonts.tajawal(fontSize: 12, color: AppColors.textSecondary)),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
    );
  }
}
