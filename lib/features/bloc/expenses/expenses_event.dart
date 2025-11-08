part of 'expenses_bloc.dart';

@immutable
abstract class ExpensesEvent {}

class LoadExpenses extends ExpensesEvent {}

class AddExpense extends ExpensesEvent {
  final Expense expense;
  AddExpense(this.expense);
}

class DeleteExpense extends ExpensesEvent {
  final String id;
  DeleteExpense(this.id);
}