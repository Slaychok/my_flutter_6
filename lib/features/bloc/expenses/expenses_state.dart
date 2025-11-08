part of 'expenses_bloc.dart';

@immutable
abstract class ExpensesState {}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesLoaded extends ExpensesState {
  final List<Expense> expenses;
  final double totalAmount;
  final Map<String, double> categoryTotals;

  ExpensesLoaded({
    required this.expenses,
    required this.totalAmount,
    required this.categoryTotals,
  });
}