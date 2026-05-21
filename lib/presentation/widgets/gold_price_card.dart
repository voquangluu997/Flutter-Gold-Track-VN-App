import 'package:flutter/material.dart';
import 'package:gold_track_app/core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../domain/entities/gold_price.dart';

class GoldPriceCard extends StatelessWidget {
  final GoldPrice price;
  final VoidCallback? onTap;

  const GoldPriceCard({
    super.key,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    const cardColor = AppColors.etherealSupperWhite;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            _buildAvatar(primaryColor),
            const SizedBox(width: 16),
            Expanded(child: _buildInfo()),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(Color primaryColor) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            primaryColor.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Center(
        child: Text(
          price.brand[0],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          price.brand,
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Flexible(
              child: _buildPriceChip('MUA VÀO', price.buyPrice, Colors.green),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: _buildPriceChip('BÁN RxxA', price.sellPrice, Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceChip(String label, int price, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            PriceFormatter.formatCompact(price),
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 11,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}