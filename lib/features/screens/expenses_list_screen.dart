// features/screens/expenses_list_screen.dart
import 'package:flutter/material.dart';
import 'package:my_flutter_6/features/screens/StatisticsScreenGetIt.dart';
import 'package:my_flutter_6/features/widgets/app_inherited_widget.dart'; // Исправлено имя
import 'package:my_flutter_6/features/widgets/expenses_list_view.dart';
import 'package:my_flutter_6/di/locator.dart';
import 'package:my_flutter_6/features/services/settings_service.dart';

class ExpensesListScreen extends StatelessWidget {
  final VoidCallback onAdd;

  const ExpensesListScreen({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = AppInheritedWidget.of(context).appState; // InheritedWidget
    final settingsService = getIt<SettingsService>(); // GetIt

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои Расходы'),
        actions: [
          IconButton(
            icon: Icon(settingsService.isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => settingsService.toggleTheme(), // Метод из GetIt
          ),
          // Добавляем кнопку для перехода к статистике GetIt
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const StatisticsScreenGetIt(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Бюджет из GetIt
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Месячный бюджет:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '${settingsService.monthlyBudget.toStringAsFixed(2)} ₽',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Прогресс расходов
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Использовано: ${appState.totalAmount.toStringAsFixed(2)} ₽',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: settingsService.monthlyBudget > 0
                        ? appState.totalAmount / settingsService.monthlyBudget
                        : 0,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      appState.totalAmount > settingsService.monthlyBudget
                          ? Colors.red
                          : Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${((settingsService.monthlyBudget > 0 ? appState.totalAmount / settingsService.monthlyBudget : 0) * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ExpensesListView(
              expenses: appState.expenses, // Данные из InheritedWidget
              onDelete: appState.deleteExpense, // Функция из InheritedWidget
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}