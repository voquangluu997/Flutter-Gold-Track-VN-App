// lib/core/widgets/bottom_navigation.dart
import 'package:flutter/material.dart';
import 'package:gold_track_app/core/theme/app_typography.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(context, Icons.home, 'Trang chủ', true, primaryColor),
              _buildNavItem(context, Icons.show_chart, 'Biểu đồ', false, primaryColor),
              _buildNavItem(context, Icons.notifications, 'Cảnh báo', false, primaryColor),
              _buildNavItem(context, Icons.person, 'Cá nhân', false, primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, bool isActive, Color primaryColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? primaryColor : Colors.grey,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: isActive ? primaryColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}