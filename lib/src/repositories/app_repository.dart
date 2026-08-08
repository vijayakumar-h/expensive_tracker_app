import 'package:expensive_tracker_app/src/utils/common_exports.dart';

/// Singletons start here:
/// [AppRepository] is registered as a Lazy Singleton in GetIt.
/// It receives [ApiService] via constructor injection to integrate local storage (Hive)
/// with remote HTTP operations and globalization headers.
class AppRepository with HiveServices {
  final ApiService? apiService;

  AppRepository({this.apiService});

  Future<void> init() async {
    await initializeHive();
    final categoriesMap = getFromHive('categories', defaultValue: {}) as Map<dynamic, dynamic>;
    if (categoriesMap.isEmpty) {
      await saveCategories(_defaultCategories);
    }
    // Sync active language header in ApiService Singleton
    final currentLang = getLanguage();
    apiService?.setLanguage(currentLang);
  }

  List<CategoryModel> getCategories() {
    final categoriesMap = getFromHive('categories', defaultValue: {}) as Map<dynamic, dynamic>;
    if (categoriesMap.isNotEmpty) {
      return categoriesMap.values
          .map((c) => CategoryModel.fromMap(Map<dynamic, dynamic>.from(c as Map)))
          .toList();
    }
    return _defaultCategories;
  }

  Future<void> saveCategories(List<CategoryModel> categories) async {
    final Map<String, dynamic> categoriesMap = {
      for (var c in categories) c.id: c.toMap()
    };
    await storeFromHive('categories', categoriesMap);
  }

  List<Expense> getExpenses() {
    final expensesMap = getFromHive('expenses', defaultValue: {}) as Map<dynamic, dynamic>;
    if (expensesMap.isEmpty) return [];

    return expensesMap.values
        .map((e) => Expense.fromMap(Map<dynamic, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> saveExpense(Expense expense) async {
    final expensesMap = getFromHive('expenses', defaultValue: {}) as Map<dynamic, dynamic>;
    final newMap = Map<dynamic, dynamic>.from(expensesMap);
    newMap[expense.id] = expense.toMap();
    await storeFromHive('expenses', newMap);
  }

  Future<void> deleteExpense(String id) async {
    final expensesMap = getFromHive('expenses', defaultValue: {}) as Map<dynamic, dynamic>;
    final newMap = Map<dynamic, dynamic>.from(expensesMap);
    newMap.remove(id);
    await storeFromHive('expenses', newMap);
  }

  ThemeMode getTheme() {
    final String themeModeName = getFromHive('themeValue')?.toString() ?? ThemeMode.system.name;
    return ThemeMode.values.singleWhere((element) => element.name == themeModeName);
  }

  Future<void> saveTheme(ThemeMode themeMode) async {
    await storeFromHive('themeValue', themeMode.name);
  }

  String getLanguage() {
    return getFromHive('languageCode')?.toString() ?? 'en';
  }

  Future<void> saveLanguage(String languageCode) async {
    await storeFromHive('languageCode', languageCode);
    apiService?.setLanguage(languageCode);
  }

  UserModel getUser() {
    final userMap = getFromHive('userProfile');
    if (userMap != null) {
      final map = Map<String, dynamic>.from(userMap as Map);
      return UserModel(
        name: map['name'] ?? 'Vijay Kumar',
        email: map['email'] ?? 'vijay@example.com',
        profileImageUrl: map['profileImageUrl'] ?? '',
      );
    }
    return const UserModel(name: 'Vijay Kumar', email: 'vijay@example.com');
  }

  Future<void> saveUser(UserModel user) async {
    await storeFromHive('userProfile', {
      'name': user.name,
      'email': user.email,
      'profileImageUrl': user.profileImageUrl,
    });
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
