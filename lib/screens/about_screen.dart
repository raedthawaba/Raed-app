import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'حول التطبيق',
          style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            children: [
              const SizedBox(height: AppDimensions.paddingXLarge),
              _buildAppLogo(),
              const SizedBox(height: AppDimensions.paddingLarge * 2),
              _buildAppInfo(),
              const SizedBox(height: AppDimensions.paddingXLarge * 2),
              _buildAboutSection(),
              const SizedBox(height: AppDimensions.paddingLarge * 2),
              _buildFeaturesSection(),
              const SizedBox(height: AppDimensions.paddingLarge * 2),
              _buildLegalSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Column(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: const Icon(
            Icons.admin_panel_settings,
            size: 70,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        Text(
          'نظام إدارة الألوية',
          style: GoogleFonts.tajawal(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'الإصدار 1.0.0',
            style: GoogleFonts.tajawal(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppInfo() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius * 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow('المطور', 'Raed Thawaba', Icons.person),
          const Divider(),
          _buildInfoRow('تاريخ الإصدار', '21 فبراير 2026', Icons.calendar_today),
          const Divider(),
          _buildInfoRow('آخر تحديث', '21 فبراير 2026', Icons.update),
          const Divider(),
          _buildInfoRow('نظام التشغيل', 'Android / iOS / Web', Icons.phone_android),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: AppColors.textSecondary,
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
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.info, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'عن التطبيق',
              style: GoogleFonts.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingMedium),
        Container(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          ),
          child: Text(
            'نظام إدارة الألوية هو نظام متكامل لإدارة الأقسام العسكرية المختلفة. يهدف النظام إلى تسهيل إدارة العمليات العسكرية وتوفير واجهة مستخدم سهلة الاستخدام.',
            style: GoogleFonts.tajawal(
              fontSize: 14,
              color: AppColors.textPrimary,
              height: 1.6,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      {'icon': Icons.shield, 'title': 'إدارة الألوية', 'desc': 'إدارة ستة ألوية مختلفة'},
      {'icon': Icons.people, 'title': 'إدارة الأفراد', 'desc': 'تابعة شؤون الأفراد'},
      {'icon': Icons.security, 'title': 'الأمان', 'desc': 'نظام حماية متقدم'},
      {'icon': Icons.notifications, 'title': 'الإشعارات', 'desc': 'تنبيهات فورية'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.star, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'الميزات الرئيسية',
              style: GoogleFonts.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingMedium),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    features[index]['icon'] as IconData,
                    color: AppColors.primary,
                    size: 30,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    features[index]['title'] as String,
                    style: GoogleFonts.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    features[index]['desc'] as String,
                    style: GoogleFonts.tajawal(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLegalSection() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius * 2),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            'جميع الحقوق محفوظة',
            style: GoogleFonts.tajawal(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '© 2026 نظام إدارة الألوية',
            style: GoogleFonts.tajawal(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegalLink('شروط الاستخدام'),
              const SizedBox(width: 16),
              _buildLegalLink('سياسة الخصوصية'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegalLink(String text) {
    return Text(
      text,
      style: GoogleFonts.tajawal(
        fontSize: 12,
        color: AppColors.primary,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
