import 'package:flutter/material.dart';
import 'package:my_flutter_6/features/models/expense.dart';
import 'expense_row.dart';

class ExpensesListView extends StatelessWidget {
  final List<Expense> expenses;
  final Function(String id) onDelete;
  final Function(Expense expense)? onTap;

  const ExpensesListView({
    Key? key,
    required this.expenses,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  double get totalAmount {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text('Список расходов пуст'),
      );
    }

    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Общая сумма:',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '${totalAmount.toStringAsFixed(2)} ₽',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return ExpenseRow(
                key: ValueKey(expense.id),
                expense: expense,
                onDelete: () => onDelete(expense.id),
                onTap: onTap != null ? () => onTap!(expense) : null,
              );
            },
          ),
        ),
      ],
    );
  }
}