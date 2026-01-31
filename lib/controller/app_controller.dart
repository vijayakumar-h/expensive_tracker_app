import 'package:expensive_tracker_app/utils/common_exports.dart';

class AppController with ChangeNotifier, AppMixin, HiveServices {
  factory AppController() => _singleton;
  static final AppController _singleton = AppController._internal();

  AppController._internal();

  List<Expense> expenses = [];
  List<CategoryModel> availableCategories = [
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

  Future<void> initializeHive() async {
    await super.initializeHive();
    expenses = getExpensesFromHive();

    // Load categories
    final categoriesMap =
        getFromHive('categories', defaultValue: {}) as Map<dynamic, dynamic>;
    if (categoriesMap.isNotEmpty) {
      availableCategories = categoriesMap.values
          .map((c) =>
              CategoryModel.fromMap(Map<dynamic, dynamic>.from(c as Map)))
          .toList();
    } else {
      // First run: persist defaults
      await _saveCategoriesToHive();
    }

    notifyListeners();
  }

  Future<void> _saveCategoriesToHive() async {
    final Map<String, dynamic> categoriesMap = {
      for (var c in availableCategories) c.id: c.toMap()
    };
    await storeFromHive('categories', categoriesMap);
  }

  Future<void> addCategory(CategoryModel category) async {
    availableCategories.add(category);
    await _saveCategoriesToHive();
    notifyListeners();
  }

  List<Expense> getExpensesFromHive() {
    final expensesMap =
        getFromHive('expenses', defaultValue: {}) as Map<dynamic, dynamic>;
    if (expensesMap.isEmpty) return [];

    return expensesMap.values
        .map((e) => Expense.fromMap(Map<dynamic, dynamic>.from(e as Map)))
        .toList();
  }

  // Renamed to avoid incorrect override and provide specific functionality
  Future<void> saveExpense(String key, Map<String, dynamic> value) async {
    final expensesMap =
        getFromHive('expenses', defaultValue: {}) as Map<dynamic, dynamic>;
    // Create a mutable copy
    final newMap = Map<dynamic, dynamic>.from(expensesMap);
    newMap[key] = value;

    await storeFromHive('expenses', newMap);
    expenses = getExpensesFromHive();
    notifyListeners();
  }

  // Renamed to avoid incorrect override
  Future<void> removeExpense(String key) async {
    final expensesMap =
        getFromHive('expenses', defaultValue: {}) as Map<dynamic, dynamic>;
    // Create a mutable copy
    final newMap = Map<dynamic, dynamic>.from(expensesMap);
    newMap.remove(key);

    await storeFromHive('expenses', newMap);
    expenses = getExpensesFromHive();
    notifyListeners();
  }

  set setAppTheme(ThemeMode themeMode) {
    appController.storeFromHive('themeValue', themeMode.name);
    appThemeModeNotifier.value = themeMode;
  }

  void setupInitialAppTheme() {
    final String themeModeName =
        appController.getFromHive('themeValue')?.toString() ??
            appThemeModeNotifier.value.name;
    final ThemeMode themeMode = ThemeMode.values
        .singleWhere((element) => element.name == themeModeName);
    setAppTheme = themeMode;
  }

  Future<void> draggableBottomSheet({
    bool expand = false,
    double? minChildSize,
    double? maxChildSize,
    double? initialChildSize,
    bool isScrollControlled = true,
    required BuildContext context,
    DraggableScrollableController? draggableController,
    required Widget Function(BuildContext, ScrollController) builder,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kAppBorderRadius),
          borderSide: BorderSide(
            width: 0.0,
            style: BorderStyle.none,
            color: Colors.transparent,
          ),
        ),
        sheetAnimationStyle: AnimationStyle(
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
        ),
        builder: (BuildContext context) => DraggableScrollableSheet(
          builder: builder,
          expand: expand,
          controller: draggableController,
          minChildSize: minChildSize ?? 0.5,
          maxChildSize: maxChildSize ?? 0.80,
          initialChildSize: initialChildSize ?? 0.5,
        ),
      );
}

mixin AppMixin {
  final ValueNotifier<ThemeMode> appThemeModeNotifier =
      ValueNotifier(ThemeMode.system);
}
