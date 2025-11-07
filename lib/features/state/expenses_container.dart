// features/state/expenses_container.dart
import 'package:flutter/material.dart';
import 'package:my_flutter_6/features/models/expense.dart';
import '../screens/expenses_list_screen.dart';
import '../screens/expense_form_screen.dart';
import 'app_state.dart';
import '../../di/locator.dart';
import '../widgets/app_inherited_widget.dart';

enum Screen { list, form }

class ExpensesContainer extends StatefulWidget {
  const ExpensesContainer({super.key});

  @override
  State<ExpensesContainer> createState() => _ExpensesContainerState();
}

class _ExpensesContainerState extends State<ExpensesContainer> {
  final AppState _appState = getIt<AppState>(); // GetIt доступ
  Screen _currentScreen = Screen.list;

  void _showList() {
    setState(() => _currentScreen = Screen.list);
  }

  void _showForm() {
    setState(() => _currentScreen = Screen.form);
  }

  void _addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String category,
    String? description,
  }) {
    final newExpense = Expense(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      date: date,
      category: category,
      description: description,
    );
    _appState.addExpense(newExpense);
    _showList();
  }

  @override
  Widget build(BuildContext context) {
    return AppInheritedWidget( // InheritedWidget доступ
      appState: _appState,
      child: _buildCurrentScreen(),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentScreen) {
      case Screen.list:
        return ExpensesListScreen(
          onAdd: _showForm,
        );
      case Screen.form:
        return ExpenseFormScreen(
          onSave: _addExpense,
          onCancel: _showList,
        );
    }
  }
}