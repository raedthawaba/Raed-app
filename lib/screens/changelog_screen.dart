import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

class ChangelogScreen extends StatelessWidget {
  const ChangelogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'سجل التحديثات',
          style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          children: [
            _buildVersionCard(
              version: '1.0.0',
              date: '21 فبراير 2026',
              title: 'الإصدار الأولي',
              description: 'إطلاق النظام الأولي مع الميزات الأساسية',
              isNew: true,
              features: [
                'صفحة تسجيل دخول المسؤول',
                'صفحة الرئيسية مع ستة ألوية',
                'صفحة القسم الأول مع 13 فرعية',
                'نظام الإعدادات',
                'القائمة الجانبية',
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildVersionCard(
              version: '0.9.0',
              date: '15 فبراير 2026',
              title: 'تحسينات登录',
              description: 'تحسين صفحة تسجيل الدخول وإضافة التحقق',
              features: [
                'إضافة التحقق من صحة النموذج',
                'تحسين واجهة المستخدم',
                'إصلاح الأخطاء',
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildVersionCard(
              version: '0.8.0',
              date: '10 فبراير 2026',
              title: 'تحسينات التصميم',
              description: 'تحسين التصميم واجهة المستخدم',
              features: [
                'تحسين الألوان',
                'إضافة تأثيرات الظل',
                'تحسين الخطوط',
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildVersionCard(
              version: '0.7.0',
              date: '1 فبراير 2026',
              title: 'بدء التطوير',
              description: 'بدء تطوير النظام',
              features: [
                'إنشاء المشروع',
                'إعداد Flutter',
                'إضافة مكتبات المطلوبة',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersionCard({
    required String version,
    required String date,
    required String title,
    required String description,
    required List<String> features,
    bool isNew = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius * 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: isNew ? AppColors.primary : AppColors.primaryLight.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppDimensions.borderRadius * 2),
                topRight: Radius.circular(AppDimensions.borderRadius * 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isNew ? Colors.white : AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    version,
                    style: GoogleFonts.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isNew ? AppColors.primary : Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                if (isNew)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'جديد',
                      style: GoogleFonts.tajawal(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: isNew ? Colors.white : AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  date,
                  style: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: isNew ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                const Divider(),
                const SizedBox(height: AppDimensions.paddingSmall),
                Text(
                  'الميزات:',
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: GoogleFonts.tajawal(
                            fontSize: 13,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
