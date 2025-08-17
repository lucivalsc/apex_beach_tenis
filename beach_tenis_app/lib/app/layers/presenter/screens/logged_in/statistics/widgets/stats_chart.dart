import 'package:flutter/material.dart';
import '../../../../../../common/styles/app_styles.dart';

class StatsChart extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;
  final Color color;

  const StatsChart({
    Key? key,
    required this.title,
    required this.data,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppStyles.mediumSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppStyles.grey800,
              ),
            ),
            const SizedBox(height: AppStyles.mediumSpace),
            SizedBox(
              height: 200,
              child: _buildChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    // Encontrar o valor máximo para escala
    final maxValue = data.map((e) => e['valor'] as int).reduce((a, b) => a > b ? a : b).toDouble();
    
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: data.map((item) {
              final value = item['valor'] as int;
              final label = item['data'] as String;
              final barHeight = (value / maxValue) * 100;
              
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: barHeight * 1.5,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.8),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(AppStyles.radiusSmall),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: AppStyles.smallSpace),
        Row(
          children: data.map((item) {
            final label = item['data'] as String;
            
            return Expanded(
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppStyles.grey600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
