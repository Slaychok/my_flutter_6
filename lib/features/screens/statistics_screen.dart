// features/screens/statistics_screen.dart
import 'package:flutter/material.dart';
import 'package:my_flutter_6/features/widgets/app_inherited_widget.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Используем InheritedWidget для получения данных
    final appState = AppInheritedWidget.of(context).appState;
    final expenses = appState.expenses;
    final categoryTotals = appState.getCategoryTotals();
    final totalAmount = appState.totalAmount;

    final sortedCategories = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика расходов'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Общая сумма:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalAmount.toStringAsFixed(2)} ₽',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
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
                itemCount: sortedCategories.length,
                itemBuilder: (context, index) {
                  final entry = sortedCategories[index];
                  final category = entry.key;
                  final amount = entry.value;
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