import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/price_formatter.dart';
import '../../../data/repositories/gold_repository.dart';
import '../../blocs/gold_detail/gold_detail_bloc.dart';
import '../../blocs/gold_detail/gold_detail_event.dart';
import '../../blocs/gold_detail/gold_detail_state.dart';
import 'widgets/price_chart.dart';
import 'widgets/price_history_table.dart';
import 'widgets/stat_cards.dart';

class GoldDetailScreen extends StatelessWidget {
  final String brand;
  final String city;

  const GoldDetailScreen({
    super.key,
    required this.brand,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    final isEthereal = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => GoldDetailBloc(GoldRepository())
        ..add(LoadGoldDetail(brand: brand, city: city)),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            decoration: isEthereal
                ? const BoxDecoration(
                    gradient: AppColors.etherealGradient,
                  )
                : null,
            child: AppBar(
              title: Text(brand),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<GoldDetailBloc, GoldDetailState>(
          builder: (context, state) {
            if (state is GoldDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GoldDetailLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCurrentPrice(state, context),
                    const SizedBox(height: 24),
                    PriceChart(prices: state.historyPrices),
                    const SizedBox(height: 24),
                    StatCards(
                      highest: state.highestPrice,
                      lowest: state.lowestPrice,
                      average: state.averagePrice,
                    ),
                    const SizedBox(height: 24),
                    PriceHistoryTable(prices: state.historyPrices),
                    const SizedBox(height: 24),
                    _buildActionButtons(context, isEthereal),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            }
            if (state is GoldDetailError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<GoldDetailBloc>().add(
                          LoadGoldDetail(brand: brand, city: city),
                        );
                      },
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildCurrentPrice(GoldDetailLoaded state, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPriceColumn('MUA VÀO', state.currentPrice.buyPrice, AppColors.etherealPriceBuy),
          Container(width: 1, height: 50, color: Colors.grey.shade800),
          _buildPriceColumn('BÁN RA', state.currentPrice.sellPrice, AppColors.etherealPriceSell),
        ],
      ),
    );
  }

  Widget _buildPriceColumn(String label, int price, Color color) {
    return Column(
      children: [
        Text(label, style: AppTypography.caption.copyWith(color: Colors.grey)),
        const SizedBox(height: 8),
        Text(
          PriceFormatter.formatCompact(price),
          style: AppTypography.displayMedium.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isEthereal) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: isEthereal
                ? BoxDecoration(
                    gradient: AppColors.etherealGradient,
                    borderRadius: BorderRadius.circular(40),
                  )
                : null,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isEthereal ? Colors.transparent : Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text('ĐẶT CẢNH BÁO'),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: isEthereal ? AppColors.coral : Theme.of(context).primaryColor,
              side: BorderSide(color: isEthereal ? AppColors.coral : Theme.of(context).primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Text('TỶ GIÁ LIÊN QUAN'),
          ),
        ),
      ],
    );
  }
}