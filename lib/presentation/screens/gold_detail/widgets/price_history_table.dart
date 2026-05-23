import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../domain/entities/gold_price.dart';

class PriceHistoryTable extends StatefulWidget {
  final List<GoldPrice> prices;

  const PriceHistoryTable({super.key, required this.prices});

  @override
  State<PriceHistoryTable> createState() => _PriceHistoryTableState();
}

class _PriceHistoryTableState extends State<PriceHistoryTable> {
  int _visibleCount = 7;
  late List<GoldPrice> _sortedPrices;

  @override
  void initState() {
    super.initState();
    _sortedPrices = List.from(widget.prices.reversed);
  }

  @override
  void didUpdateWidget(covariant PriceHistoryTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sortedPrices = List.from(widget.prices.reversed);
  }

  @override
  Widget build(BuildContext context) {
    final displayPrices = _sortedPrices.take(_visibleCount).toList();
    final hasMore = _visibleCount < _sortedPrices.length;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Lịch sử giá', style: AppTypography.displaySmall),
            if (hasMore)
              TextButton(
                onPressed: () {
                  setState(() {
                    _visibleCount += 10;
                  });
                },
                child: const Text('Xem thêm'),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: screenWidth - 32, // ✅ Chiếm toàn bộ chiều rộng màn hình
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      _buildHeaderCell('Ngày', flex: 2),
                      _buildHeaderCell('Mua vào', flex: 2),
                      _buildHeaderCell('Bán ra', flex: 2),
                      _buildHeaderCell('Chênh lệch', flex: 2),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Dữ liệu
                ...displayPrices.map((price) {
                  final dateFormat = DateFormat('dd/MM');
                  final change = _calculateChange(price);
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade100),
                      ),
                    ),
                    child: Row(
                      children: [
                        _buildDataCell(
                          Text(dateFormat.format(price.createdAt), 
                              style: AppTypography.bodySmall),
                          flex: 2,
                        ),
                        _buildDataCell(
                          Text(
                            PriceFormatter.formatCompact(price.buyPrice),
                            style: AppTypography.bodySmall.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          flex: 2,
                        ),
                        _buildDataCell(
                          Text(
                            PriceFormatter.formatCompact(price.sellPrice),
                            style: AppTypography.bodySmall.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          flex: 2,
                        ),
                        _buildDataCell(
                          _buildChangeCell(change),
                          flex: 2,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        if (!hasMore && _sortedPrices.length > 7)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: Text(
                'Đã hiển thị tất cả ${_sortedPrices.length} ngày',
                style: AppTypography.caption.copyWith(color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: AppTypography.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataCell(Widget child, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Center(child: child),
    );
  }

  double _calculateChange(GoldPrice price) {
    final index = _sortedPrices.indexOf(price);
    if (index + 1 >= _sortedPrices.length) return 0;
    final previousPrice = _sortedPrices[index + 1];
    if (previousPrice.sellPrice == 0) return 0;
    return ((price.sellPrice - previousPrice.sellPrice) / previousPrice.sellPrice) * 100;
  }

  Widget _buildChangeCell(double change) {
    final isPositive = change >= 0;
    final color = isPositive ? Colors.green : Colors.red;
    final icon = isPositive ? Icons.trending_up : Icons.trending_down;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 2),
        Flexible(
          child: Text(
            '${isPositive ? '+' : ''}${change.toStringAsFixed(1)}%',
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}