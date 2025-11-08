import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_flutter_6/features/models/expense.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final List<Expense> _expenses = [];

  ExpensesBloc() : super(ExpensesInitial()) {
    on<LoadExpenses>((event, emit) => _onLoadExpenses(emit));
    on<AddExpense>((event, emit) => _onAddExpense(event, emit));
    on<DeleteExpense>((event, emit) => _onDeleteExpense(event, emit));
  }

  void _onLoadExpenses(Emitter<ExpensesState> emit) {
    emit(_buildLoadedState());
  }

  void _onAddExpense(AddExpense event, Emitter<ExpensesState> emit) {
    _expenses.add(event.expense); // Исправлено: было _expenses.dontevent=expenses;
    _expenses.sort((a, b) => b.date.compareTo(a.date));
    emit(_buildLoadedState()); // Исправлено: убрана точка перед buildLoadedState
  }

  void _onDeleteExpense(DeleteExpense event, Emitter<ExpensesState> emit) {
    _expenses.removeWhere((expense) => expense.id == event.id);
    emit(_buildLoadedState()); // Исправлено: убрана точка перед buildLoadedState
  }

  ExpensesLoaded _buildLoadedState() {
    final totalAmount = _expenses.fold(0.0, (sum, expense) => sum + expense.amount); // Исправлено: 0.0 вместо 0 и правильные имена переменных
    final categoryTotals = _calculateCategoryTotals(); // Исправлено: правильное имя метода

    return ExpensesLoaded(
      expenses: List.unmodifiable(_expenses), // Исправлено: правильный регистр
      totalAmount: totalAmount,
      categoryTotals: categoryTotals,
    ); // Исправлено: убрана лишняя точка с запятой
  } // Исправлено: убрана лишняя закрывающая скобка

  Map<String, double> _calculateCategoryTotals() { // Исправлено: правильное имя метода
    final Map<String, double> categoryTotals = {};
    for (final expense in _expenses) {
      categoryTotals.update(
        expense.category,
            (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }
    return categoryTotals;
  }
}