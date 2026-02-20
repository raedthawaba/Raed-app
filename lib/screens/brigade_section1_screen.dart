import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

class BrigadeSection1Screen extends StatelessWidget {
  const BrigadeSection1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          AppStrings.brigadeSection1,
          style: GoogleFonts.tajawal(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildSectionsGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Text(
            AppStrings.brigadeSection1,
            style: GoogleFonts.tajawal(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Text(
            'اختر القسم المطلوب',
            style: GoogleFonts.tajawal(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionsGrid() {
    final List<Map<String, dynamic>> sections = [
      {
        'title': AppStrings.brigade1Section1,
        'icon': Icons.people,
        'color': const Color(0xFF1565C0),
      },
      {
        'title': AppStrings.brigade1Section2,
        'icon': Icons.shield,
        'color': const Color(0xFF2E7D32),
      },
      {
        'title': AppStrings.brigade1Section3,
        'icon': Icons.folder,
        'color': const Color(0xFFE65100),
      },
      {
        'title': AppStrings.brigade1Section4,
        'icon': Icons.visibility,
        'color': const Color(0xFF6A1B9A),
      },
      {
        'title': AppStrings.brigade1Section5,
        'icon': Icons.build,
        'color': const Color(0xFF00838F),
      },
      {
        'title': AppStrings.brigade1Section6,
        'icon': Icons.local_hospital,
        'color': const Color(0xFFC62828),
      },
      {
        'title': AppStrings.brigade1Section7,
        'icon': Icons.local_police,
        'color': const Color(0xFF4527A0),
      },
      {
        'title': AppStrings.brigade1Section8,
        'icon': Icons.dashboard,
        'color': const Color(0xFF00897B),
      },
      {
        'title': AppStrings.brigade1Section9,
        'icon': Icons.construction,
        'color': const Color(0xFF5D4037),
      },
      {
        'title': AppStrings.brigade1Section10,
        'icon': Icons.star,
        'color': const Color(0xFFD4AF37),
      },
      {
        'title': AppStrings.brigade1Section11,
        'icon': Icons.flag,
        'color': const Color(0xFF1B5E20),
      },
      {
        'title': AppStrings.brigade1Section12,
        'icon': Icons.campaign,
        'color': const Color(0xFFE91E63),
      },
      {
        'title': AppStrings.brigade1Section13,
        'icon': Icons.attach_money,
        'color': const Color(0xFF0097A7),
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return _buildSectionCard(
            context,
            sections[index]['title'],
            sections[index]['icon'],
            sections[index]['color'],
          );
        },
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _showSectionDialog(context, title);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: color,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSectionDialog(BuildContext context, String sectionTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          sectionTitle,
          style: GoogleFonts.tajawal(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'سيتم تطوير هذا القسم قريباً',
          style: GoogleFonts.tajawal(),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'حسناً',
              style: GoogleFonts.tajawal(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
