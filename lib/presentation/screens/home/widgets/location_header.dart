import 'package:flutter/material.dart';
import 'package:gold_track_app/core/theme/app_colors.dart';
import 'package:gold_track_app/core/widgets/gradient_icon.dart';
import 'package:gold_track_app/core/widgets/gradient_text.dart';
import '../../../../core/theme/app_typography.dart';

class LocationHeader extends StatelessWidget {
  final String city;
  final DateTime lastUpdated;
  final VoidCallback onCityTap;

  const LocationHeader({
    super.key,
    required this.city,
    required this.lastUpdated,
    required this.onCityTap,
  });

  String _getCityDisplayName(String cityCode) {
    switch (cityCode) {
      case 'Hanoi': return 'Hà Nội';
      case 'HCMC': return 'TP. Hồ Chí Minh';
      case 'Danang': return 'Đà Nẵng';
      default: return cityCode;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} - ${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.transparent, // Border trong suốt để lộ gradient bên dưới
                width: 2,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.etherealGradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                margin: const EdgeInsets.all(1), // Độ dày border
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
            child: const GradientIcon(Icons.location_on, size: 24),

              )),
            
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('VỊ TRÍ HIỆN TẠI', style: AppTypography.bodySmall.copyWith(color: AppColors.dark, fontWeight: FontWeight.bold)),
                GradientText(
                  _getCityDisplayName(city),
                  style: AppTypography.headlineLarge,
                ),
                Text(
                  'Cập nhật: ${_formatDate(lastUpdated)}',
                  style: AppTypography.caption.copyWith(color: AppColors.dark.withValues(alpha: 0.8),
                )),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: onCityTap,
            style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.etherealPrimary, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            ),
            child: Text(
              'Đổi',
              style: AppTypography.bodyMedium.copyWith(color: primaryColor, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}