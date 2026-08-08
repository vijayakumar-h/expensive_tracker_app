import 'package:expensive_tracker_app/common_exports.dart';

abstract class ExpenseRepository {
  Future<void> init();

  List<CategoryModel> getCategories();

  Future<void> saveCategories(List<CategoryModel> categories);

  List<Expense> getExpenses();

  Future<void> saveExpense(Expense expense);

  Future<void> deleteExpense(String id);
}
