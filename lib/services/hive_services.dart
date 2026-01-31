import 'package:expensive_tracker_app/utils/common_exports.dart';


mixin HiveServices {
  late Box<dynamic> _photoEditorBox;

  Future<void> _initializeHive() async =>
      _photoEditorBox = await Hive.openBox<dynamic>('_photoEditorBox');

  Future<void> storeFromHive(Object key, Object value) async {
    try {
      await _photoEditorBox.put(key, value);
    } catch (e) {
      rethrow;
    }
  }

  dynamic getFromHive(Object key, {dynamic defaultValue}) =>
      _photoEditorBox.get(key, defaultValue: defaultValue);

  bool containsKeyInHive(Object key) => _photoEditorBox.containsKey(key);

  Future<void> deleteFromHive(Object key) async {
    try {
      await _photoEditorBox.delete(key);
    } catch (e) {
      rethrow;
    }
  }
  Future<void> initializeHive()async {
    await _initializeHive();
  }
}
