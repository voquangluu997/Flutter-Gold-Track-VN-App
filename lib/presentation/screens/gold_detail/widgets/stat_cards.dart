import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/price_formatter.dart';

class StatCards extends StatelessWidget {
  final double highest;
  final double lowest;
  final double average;

  const StatCards({
    super.key,
    required this.highest,
    required this.lowest,
    required this.average,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(context, 'Cao nhất', highest, Colors.green),
        const SizedBox(width: 12),
        _buildStatCard(context, 'Thấp nhất', lowest, Colors.red),
        const SizedBox(width: 12),
        _buildStatCard(context, 'Trung bình', average, Theme.of(context).primaryColor),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, double value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,  
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(label, style: AppTypography.caption.copyWith(color: Colors.grey)),
            const SizedBox(height: 4),
            Text(
              _formatPrice(value),
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)} tr';
    }
    return PriceFormatter.format(value.toInt());
  }
}