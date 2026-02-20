import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _selectedRating = 0;
  final _reviewController = TextEditingController();
  
  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'تقييم التطبيق',
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
              _buildAppIcon(),
              const SizedBox(height: AppDimensions.paddingLarge),
              _buildTitle(),
              const SizedBox(height: AppDimensions.paddingXLarge),
              _buildRatingStars(),
              const SizedBox(height: AppDimensions.paddingXLarge * 2),
              _buildReviewField(),
              const SizedBox(height: AppDimensions.paddingLarge * 2),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.admin_panel_settings,
        size: 60,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'نظام إدارة الألوية',
          style: GoogleFonts.tajawal(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        Text(
          'ما مدى رضاك عن التطبيق؟',
          style: GoogleFonts.tajawal(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingStars() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRating = index + 1;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  index < _selectedRating ? Icons.star : Icons.star_border,
                  size: 50,
                  color: const Color(0xFFFFD700),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppDimensions.paddingMedium),
        Text(
          _getRatingText(),
          style: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _getRatingColor(),
          ),
        ),
      ],
    );
  }

  String _getRatingText() {
    switch (_selectedRating) {
      case 1:
        return 'سيء جداً';
      case 2:
        return 'سيء';
      case 3:
        return 'مقبول';
      case 4:
        return 'جيد';
      case 5:
        return 'ممتاز';
      default:
        return 'اختر التقييم';
    }
  }

  Color _getRatingColor() {
    switch (_selectedRating) {
      case 1:
      case 2:
        return AppColors.error;
      case 3:
        return Colors.orange;
      case 4:
      case 5:
        return AppColors.success;
      default:
        return AppColors.textSecondary;
    }
  }

  Widget _buildReviewField() {
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
      child: TextField(
        controller: _reviewController,
        maxLines: 5,
        style: GoogleFonts.tajawal(),
        decoration: InputDecoration(
          hintText: 'اكتب ملاحظاتك هنا...',
          hintStyle: GoogleFonts.tajawal(color: AppColors.textSecondary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(AppDimensions.paddingMedium),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: ElevatedButton(
        onPressed: _selectedRating > 0 ? _submitRating : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
        ),
        child: Text(
          'إرسال التقييم',
          style: GoogleFonts.tajawal(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _submitRating() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'شكراً لك على تقييمك!',
          style: GoogleFonts.tajawal(),
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }
}
