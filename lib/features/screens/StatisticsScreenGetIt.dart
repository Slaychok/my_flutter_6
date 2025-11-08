// features/screens/statistics_screen_getit.dart
import 'package:flutter/material.dart';
import 'package:my_flutter_6/di/locator.dart';
import 'package:my_flutter_6/features/state/app_state.dart';
import 'package:my_flutter_6/features/services/settings_service.dart';

class StatisticsScreenGetIt extends StatelessWidget {
  const StatisticsScreenGetIt({super.key});

  @override
  Widget build(BuildContext context) {
    // Все зависимости через GetIt
    final appState = getIt<AppState>(); // GetIt
    final settingsService = getIt<SettingsService>(); // GetIt

    final categoryTotals = appState.getCategoryTotals();
    final totalAmount = appState.totalAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика (GetIt)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Общая информация через GetIt
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Всего расходов:'),
                        Text(
                          '${totalAmount.toStringAsFixed(2)} ₽',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Месячный бюджет:'),
                        Text(
                          '${settingsService.monthlyBudget.toStringAsFixed(2)} ₽',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Остаток:'),
                        Text(
                          '${(settingsService.monthlyBudget - totalAmount).toStringAsFixed(2)} ₽',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (settingsService.monthlyBudget - totalAmount) >= 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Расходы по категориям:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: categoryTotals.length,
                itemBuilder: (context, index) {
                  final category = categoryTotals.keys.elementAt(index);
                  final amount = categoryTotals[category]!;
                  final percentage = totalAmount > 0 ? (amount / totalAmount * 100) : 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getCategoryColor(category),
                        child: Text(
                          category[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(category),
                      subtitle: Text('${percentage.toStringAsFixed(1)}% от общей суммы'),
                      trailing: Text(
                        '${amount.toStringAsFixed(2)} ₽',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    final colors = {
      'Еда': Colors.red,
      'Транспорт': Colors.blue,
      'Развлечения': Colors.orange,
      'Здоровье': Colors.green,
      'Одежда': Colors.purple,
      'Дом': Colors.brown,
      'Прочее': Colors.grey,
    };
    return colors[category] ?? Colors.blue;
  }
}