import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../domain/entities/gold_price.dart';

enum TimeRange { week, month, threeMonths, year }

extension TimeRangeExtension on TimeRange {
  String get label {
    switch (this) {
      case TimeRange.week:
        return '1T';
      case TimeRange.month:
        return '1T';
      case TimeRange.threeMonths:
        return '3T';
      case TimeRange.year:
        return '1N';
    }
  }

  int get days {
    switch (this) {
      case TimeRange.week:
        return 7;
      case TimeRange.month:
        return 30;
      case TimeRange.threeMonths:
        return 90;
      case TimeRange.year:
        return 365;
    }
  }
}

class PriceChart extends StatefulWidget {
  final List<GoldPrice> prices;
  final double height;

  const PriceChart({super.key, required this.prices, this.height = 250});

  @override
  State<PriceChart> createState() => _PriceChartState();
}

class _PriceChartState extends State<PriceChart> {
  TimeRange _selectedRange = TimeRange.month;

  List<GoldPrice> get _filteredPrices {
    final now = DateTime.now();
    final cutoff = now.subtract(Duration(days: _selectedRange.days));
    return widget.prices.where((p) => p.createdAt.isAfter(cutoff)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPrices = _filteredPrices;
    final primaryColor = Theme.of(context).primaryColor;
    
    if (filteredPrices.isEmpty) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.show_chart, size: 48, color: Colors.grey),
              SizedBox(height: 8),
              Text('Chưa có dữ liệu biểu đồ'),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // Bộ lọc thời gian
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: TimeRange.values.map((range) {
            final isSelected = _selectedRange == range;
            return GestureDetector(
              onTap: () => setState(() => _selectedRange = range),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  range.label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        
        // Biểu đồ
        SizedBox(
          height: widget.height,
          child: _ChartCanvas(
            prices: filteredPrices,
            timeRange: _selectedRange,
          ),
        ),
      ],
    );
  }
}

class _ChartCanvas extends StatelessWidget {
  final List<GoldPrice> prices;
  final TimeRange timeRange;

  const _ChartCanvas({required this.prices, required this.timeRange});

  @override
  Widget build(BuildContext context) {
    if (prices.isEmpty) return const SizedBox.shrink();

    final sellPrices = prices.map((p) => p.sellPrice.toDouble()).toList();
    final maxPrice = sellPrices.reduce((a, b) => a > b ? a : b);
    final minPrice = sellPrices.reduce((a, b) => a < b ? a : b);
    final range = maxPrice - minPrice;

    if (range == 0) {
      return Center(
        child: Text(
          'Giá ổn định: ${sellPrices.first.toStringAsFixed(0)} ₫',
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return CustomPaint(
      size: Size(double.infinity, 250),
      painter: _ChartPainter(
        prices: prices,
        minPrice: minPrice,
        range: range,
        timeRange: timeRange,
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<GoldPrice> prices;
  final double minPrice;
  final double range;
  final TimeRange timeRange;

  _ChartPainter({
    required this.prices,
    required this.minPrice,
    required this.range,
    required this.timeRange,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final primaryColor = AppColors.goldMain;
    
    final paint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = primaryColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final dx = size.width / (prices.length - 1);
    final dy = size.height / (range == 0 ? 1 : range);

    // Vẽ đường giá
    for (int i = 0; i < prices.length; i++) {
      final x = i * dx;
      final y = size.height - ((prices[i].sellPrice.toDouble() - minPrice) * dy);
      final clampedY = y.clamp(0.0, size.height);
      
      if (i == 0) {
        path.moveTo(x, clampedY);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, clampedY);
      } else {
        path.lineTo(x, clampedY);
        fillPath.lineTo(x, clampedY);
      }
    }
    
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Vẽ trục X với các mốc ngày
    const labelCount = 5;
    for (int i = 0; i < labelCount; i++) {
      final index = (prices.length - 1) * i ~/ (labelCount - 1);
      if (index < prices.length) {
        final x = index * dx;
        final date = prices[index].createdAt;
        final dateStr = DateFormat('dd/MM').format(date);
        
        final textPainter = TextPainter(
          text: TextSpan(
            text: dateStr,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
          textDirection: ui.TextDirection.ltr,
          textAlign: TextAlign.center,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x - textPainter.width / 2, size.height - 20),
        );
      }
    }

    // Vẽ đường lưới ngang
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    for (int i = 1; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}