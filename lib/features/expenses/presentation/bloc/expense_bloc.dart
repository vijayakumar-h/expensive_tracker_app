import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/expense_repository.dart';
import '../../data/models/category_model.dart';
import 'expense_event.dart';
import 'expense_state.dart';

/// 🔴 FEATURE-SCOPED BLoC
/// [ExpenseBloc] manages state for expenses and categories, receiving [ExpenseRepository] domain interface.
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository _repository;

  ExpenseBloc(this._repository) : super(const ExpenseState()) {
    on<LoadExpenses>((event, emit) {
      emit(state.copyWith(status: ExpenseStatus.loading));
      try {
        final expenses = _repository.getExpenses();
        final categories = _repository.getCategories();
        emit(state.copyWith(
          status: ExpenseStatus.success,
          expenses: expenses,
          categories: categories,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: ExpenseStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    });

    on<AddExpenseEvent>((event, emit) async {
      try {
        await _repository.saveExpense(event.expense);
        final expenses = _repository.getExpenses();
        emit(state.copyWith(expenses: expenses));
      } catch (e) {
        emit(state.copyWith(
          status: ExpenseStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    });

    on<DeleteExpenseEvent>((event, emit) async {
      try {
        await _repository.deleteExpense(event.id);
        final expenses = _repository.getExpenses();
        emit(state.copyWith(expenses: expenses));
      } catch (e) {
        emit(state.copyWith(
          status: ExpenseStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    });

    on<AddCategoryEvent>((event, emit) async {
      try {
        final currentCategories = List<CategoryModel>.from(state.categories);
        currentCategories.add(event.category);
        await _repository.saveCategories(currentCategories);
        emit(state.copyWith(categories: currentCategories));
      } catch (e) {
        emit(state.copyWith(
          status: ExpenseStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    });
  }
}
