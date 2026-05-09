part of 'expense_bloc.dart';

enum ExpenseStatus { initial, loading, success, failure }

class ExpenseState extends Equatable {
  final ExpenseStatus status;
  final List<Expense> expenses;
  final List<CategoryModel> categories;
  final String? errorMessage;

  const ExpenseState({
    this.status = ExpenseStatus.initial,
    this.expenses = const [],
    this.categories = const [],
    this.errorMessage,
  });

  ExpenseState copyWith({
    ExpenseStatus? status,
    List<Expense>? expenses,
    List<CategoryModel>? categories,
    String? errorMessage,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, expenses, categories, errorMessage];
}
