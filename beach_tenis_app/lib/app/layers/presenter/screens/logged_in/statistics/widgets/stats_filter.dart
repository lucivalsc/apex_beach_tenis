import 'package:flutter/material.dart';
import '../../../../../../common/styles/app_styles.dart';
import '../statistics_provider.dart';

class StatsFilter extends StatelessWidget {
  final StatisticsPeriod currentPeriod;
  final Function(StatisticsPeriod) onPeriodChanged;

  const StatsFilter({
    Key? key,
    required this.currentPeriod,
    required this.onPeriodChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppStyles.mediumSpace),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Período',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppStyles.grey800,
            ),
          ),
          const SizedBox(height: AppStyles.smallSpace),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  label: 'Hoje',
                  period: StatisticsPeriod.day,
                ),
                const SizedBox(width: AppStyles.smallSpace),
                _buildFilterChip(
                  label: 'Esta Semana',
                  period: StatisticsPeriod.week,
                ),
                const SizedBox(width: AppStyles.smallSpace),
                _buildFilterChip(
                  label: 'Este Mês',
                  period: StatisticsPeriod.month,
                ),
                const SizedBox(width: AppStyles.smallSpace),
                _buildFilterChip(
                  label: 'Este Ano',
                  period: StatisticsPeriod.year,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required StatisticsPeriod period,
  }) {
    final isSelected = currentPeriod == period;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onPeriodChanged(period),
      backgroundColor: Colors.white,
      selectedColor: AppStyles.primaryBlue.withOpacity(0.2),
      checkmarkColor: AppStyles.primaryBlue,
      labelStyle: TextStyle(
        color: isSelected ? AppStyles.primaryBlue : AppStyles.grey700,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
        side: BorderSide(
          color: isSelected ? AppStyles.primaryBlue : AppStyles.grey300,
        ),
      ),
    );
  }
}
