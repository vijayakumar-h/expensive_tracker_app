import 'package:hive/hive.dart';

/// Singletons start here:
/// [HiveService] encapsulates all local persistent storage interactions using [Hive].
class HiveService {
  late Box<dynamic> _trackerBox;

  Future<void> init() async {
    _trackerBox = await Hive.openBox<dynamic>('_expensiveTrackerBox');
  }

  Future<void> store(Object key, Object value) async {
    await _trackerBox.put(key, value);
  }

  dynamic get(Object key, {dynamic defaultValue}) {
    return _trackerBox.get(key, defaultValue: defaultValue);
  }

  bool containsKey(Object key) {
    return _trackerBox.containsKey(key);
  }

  Future<void> delete(Object key) async {
    await _trackerBox.delete(key);
  }
}
