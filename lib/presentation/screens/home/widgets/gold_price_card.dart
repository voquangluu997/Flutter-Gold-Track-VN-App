import 'package:flutter/material.dart';
import 'package:gold_track_app/core/widgets/gradient_icon.dart';
import 'package:gold_track_app/core/widgets/gradient_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../domain/entities/gold_price.dart';

class GoldPriceCard extends StatelessWidget {
  final GoldPrice price;
  final VoidCallback? onTap;

  const GoldPriceCard({super.key, required this.price, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isEthereal = Theme.of(context).brightness == Brightness.light;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          border: isEthereal 
              ? Border.all(color: AppColors.etherealSupperWhite)
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _buildAvatar(context, isEthereal),
                  const SizedBox(width: 16),
                  Expanded(child: _buildInfo(context, isEthereal)),
                  const GradientIcon(Icons.chevron_right, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, bool isEthereal) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: isEthereal ? AppColors.etherealGradient : null,
        color: isEthereal ? Theme.of(context).primaryColor : null,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Center(
        child: Text(
          price.brand[0],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context, bool isEthereal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          price.brand,
          style: AppTypography.titleMedium.copyWith(          ),
),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildPriceChip('MUA VÀO', price.buyPrice, AppColors.etherealPriceBuy, AppColors.etherealPriceBuyBg, isEthereal),
            const SizedBox(width: 12),
            _buildPriceChip('BÁN RA', price.sellPrice, AppColors.etherealPriceSell, AppColors.etherealPriceSellBg, isEthereal),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceChip(String label, int price, Color color, Color bgColor, bool isEthereal) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.bold,

            ),
          ),
          const SizedBox(height: 2),
          Text(
            PriceFormatter.formatCompact(price),
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }
}