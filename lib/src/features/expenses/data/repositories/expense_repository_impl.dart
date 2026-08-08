import 'package:expensive_tracker_app/common_exports.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;
  final ExpenseRemoteDataSource remoteDataSource;

  ExpenseRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<void> init() async {
    await localDataSource.init();
  }

  @override
  List<CategoryModel> getCategories() {
    return localDataSource.getCategories();
  }

  @override
  Future<void> saveCategories(List<CategoryModel> categories) async {
    await localDataSource.saveCategories(categories);
  }

  @override
  List<Expense> getExpenses() {
    return localDataSource.getExpenses();
  }

  @override
  Future<void> saveExpense(Expense expense) async {
    await localDataSource.saveExpense(expense);
  }

  @override
  Future<void> deleteExpense(String id) async {
    await localDataSource.deleteExpense(id);
  }
}
