import 'package:flutter/material.dart';
import 'package:my_flutter_6/features/models/expense.dart';
import 'package:my_flutter_6/features/widgets/expenses_list_view.dart';
import 'package:my_flutter_6/features/screens/images_screen.dart';

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

  void _openImagesScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const ImagesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои Расходы'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: () => _openImagesScreen(context),
            tooltip: 'Галерея изображений',
          ),
        ],
      ),
      body: ExpensesListView(
        expenses: expenses,
        onDelete: onDelete,
        onTap: onTap,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'images_btn',
            onPressed: () => _openImagesScreen(context),
            child: const Icon(Icons.photo),
            mini: true,
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: onAdd,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}