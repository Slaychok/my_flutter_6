import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_6/features/screens/StatisticsScreenGetIt.dart';
import 'package:my_flutter_6/features/widgets/expenses_list_view.dart';
import 'package:my_flutter_6/di/locator.dart';
import 'package:my_flutter_6/features/services/settings_service.dart';
import 'package:my_flutter_6/features/bloc/expenses/expenses_bloc.dart';

class ExpensesListScreen extends StatelessWidget {
  final VoidCallback onAdd;

  const ExpensesListScreen({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsService = getIt<SettingsService>();

    return BlocBuilder<ExpensesBloc, ExpensesState>(
      builder: (context, state) {
        if (state is ExpensesLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Мои Расходы'),
              actions: [
                IconButton(
                  icon: Icon(settingsService.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode),
                  onPressed: () => settingsService.toggleTheme(),
                ),
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
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Использовано: ${state.totalAmount.toStringAsFixed(2)} ₽',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: settingsService.monthlyBudget > 0
                              ? state.totalAmount / settingsService.monthlyBudget
                              : 0,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            state.totalAmount > settingsService.monthlyBudget
                                ? Colors.red
                                : Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${((settingsService.monthlyBudget > 0 ? state.totalAmount / settingsService.monthlyBudget : 0) * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ExpensesListView(
                    expenses: state.expenses,
                    onDelete: (id) => context.read<ExpensesBloc>().add(DeleteExpense(id)),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: onAdd,
              child: const Icon(Icons.add),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}