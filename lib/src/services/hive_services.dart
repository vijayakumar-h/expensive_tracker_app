import 'package:expensive_tracker_app/utils/common_exports.dart';

mixin HiveServices {
  late Box<dynamic> _expensiveTrackerBox;

  Future<void> _initializeHive() async => _expensiveTrackerBox =
      await Hive.openBox<dynamic>('_expensiveTrackerBox');

  Future<void> storeFromHive(Object key, Object value) async {
    try {
      await _expensiveTrackerBox.put(key, value);
    } catch (e) {
      rethrow;
    }
  }

  dynamic getFromHive(Object key, {dynamic defaultValue}) =>
      _expensiveTrackerBox.get(key, defaultValue: defaultValue);

  bool containsKeyInHive(Object key) => _expensiveTrackerBox.containsKey(key);

  Future<void> deleteFromHive(Object key) async {
    try {
      await _expensiveTrackerBox.delete(key);
    } catch (e) {
      rethrow;
    }
  }

  List<Expense> get expenses => _expensiveTrackerBox.values
      .whereType<Map<dynamic, dynamic>>()
      .map((e) => Expense.fromMap(Map<String, dynamic>.from(e)))
      .toList();

  Future<void> initializeHive() async {
    await _initializeHive();
  }
}
