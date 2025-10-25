import 'package:flutter/material.dart';
import 'package:my_flutter_6/features/models/expense.dart';
import 'package:my_flutter_6/features/widgets/expenses_list_view.dart';

class ExpensesListScreen extends StatelessWidget {
  final List<Expense> expenses;
  final VoidCallback onAdd;
  final Function(String id) onDelete;
  final Function(Expense expense)? onTap;

  const ExpensesListScreen({
    Key? key,
    required this.expenses,
    required this.onAdd,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои Расходы'),
      ),
      body: ExpensesListView(
        expenses: expenses,
        onDelete: onDelete,
        onTap: onTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}