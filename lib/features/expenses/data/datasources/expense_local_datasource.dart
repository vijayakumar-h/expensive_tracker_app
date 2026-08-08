import 'package:flutter/material.dart';
import '../../../../core/services/hive_service.dart';
import '../models/category_model.dart';
import '../models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<void> init();
  List<CategoryModel> getCategories();
  Future<void> saveCategories(List<CategoryModel> categories);
  List<Expense> getExpenses();
  Future<void> saveExpense(Expense expense);
  Future<void> deleteExpense(String id);
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final HiveService hiveService;

  ExpenseLocalDataSourceImpl({required this.hiveService});

  @override
  Future<void> init() async {
    await hiveService.init();
    final categoriesMap =
        hiveService.get('categories', defaultValue: {}) as Map<dynamic, dynamic>;
    if (categoriesMap.isEmpty) {
      await saveCategories(_defaultCategories);
    }
  }

  @override
  List<CategoryModel> getCategories() {
    final categoriesMap =
        hiveService.get('categories', defaultValue: {}) as Map<dynamic, dynamic>;
    if (categoriesMap.isNotEmpty) {
      return categoriesMap.values
          .map((c) => CategoryModel.fromMap(Map<dynamic, dynamic>.from(c as Map)))
          .toList();
    }
    return _defaultCategories;
  }

  @override
  Future<void> saveCategories(List<CategoryModel> categories) async {
    final Map<String, dynamic> categoriesMap = {
      for (var c in categories) c.id: c.toMap()
    };
    await hiveService.store('categories', categoriesMap);
  }

  @override
  List<Expense> getExpenses() {
    final expensesMap =
        hiveService.get('expenses', defaultValue: {}) as Map<dynamic, dynamic>;
    if (expensesMap.isEmpty) return [];

    return expensesMap.values
        .map((e) => Expense.fromMap(Map<dynamic, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<void> saveExpense(Expense expense) async {
    final expensesMap =
        hiveService.get('expenses', defaultValue: {}) as Map<dynamic, dynamic>;
    final newMap = Map<dynamic, dynamic>.from(expensesMap);
    newMap[expense.id] = expense.toMap();
    await hiveService.store('expenses', newMap);
  }

  @override
  Future<void> deleteExpense(String id) async {
    final expensesMap =
        hiveService.get('expenses', defaultValue: {}) as Map<dynamic, dynamic>;
    final newMap = Map<dynamic, dynamic>.from(expensesMap);
    newMap.remove(id);
    await hiveService.store('expenses', newMap);
  }

  final List<CategoryModel> _defaultCategories = [
    CategoryModel(
      name: 'Food',
      iconCode: Icons.lunch_dining.codePoint,
      type: TransactionType.expense,
      id: 'food',
    ),
    CategoryModel(
      name: 'Travel',
      iconCode: Icons.flight_takeoff_sharp.codePoint,
      type: TransactionType.expense,
      id: 'travel',
    ),
    CategoryModel(
      name: 'Leisure',
      iconCode: Icons.movie.codePoint,
      type: TransactionType.expense,
      id: 'leisure',
    ),
    CategoryModel(
      name: 'Work',
      iconCode: Icons.work.codePoint,
      type: TransactionType.expense,
      id: 'work',
    ),
    CategoryModel(
      name: 'Salary',
      iconCode: Icons.attach_money.codePoint,
      type: TransactionType.income,
      id: 'salary',
    ),
  ];
}
