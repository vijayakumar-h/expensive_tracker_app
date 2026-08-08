import 'package:expensive_tracker_app/src/utils/common_exports.dart';

part 'expense_event.dart';
part 'expense_state.dart';

/// 🔴 SHORT-LIVED FEATURE BLoC
/// [ExpenseBloc] handles UI state management for expenses and categories.
/// It receives [AppRepository] via constructor injection (supplied by GetIt `sl<AppRepository>()`).
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final AppRepository _repository;

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
