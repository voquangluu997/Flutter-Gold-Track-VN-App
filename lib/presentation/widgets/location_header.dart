import 'package:flutter/material.dart';
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
      case 'Hanoi':
        return 'Hà Nội';
      case 'HCMC':
        return 'TP. Hồ Chí Minh';
      case 'Danang':
        return 'Đà Nẵng';
      default:
        return cityCode;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} - ${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final cardColor = Theme.of(context).cardColor;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon location với nền tròn
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Thông tin vị trí
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vị trí hiện tại',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getCityDisplayName(city),
                  style: AppTypography.displaySmall.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Cập nhật: ${_formatDate(lastUpdated)}',
                  style: AppTypography.caption.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Nút Đổi
          GestureDetector(
            onTap: onCityTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'Đổi',
                style: AppTypography.bodySmall.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}