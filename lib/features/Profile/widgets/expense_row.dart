import 'package:flutter/material.dart';
import 'package:my_flutter_6/features/models/expense.dart';

class ExpenseRow extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const ExpenseRow({
    Key? key,
    required this.expense,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(expense.id),
      onTap: onTap,
      title: Text(expense.title),
      subtitle: Text('${expense.category} • ${_formatDate(expense.date)}'),
      trailing: Text(
        '${expense.amount.toStringAsFixed(2)} ₽',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}