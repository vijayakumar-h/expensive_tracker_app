import 'package:expensive_tracker_app/common_exports.dart';

class SettingsState extends Equatable {
  final String languageCode;

  const SettingsState({
    this.languageCode = 'en',
  });

  @override
  List<Object?> get props => [languageCode];
}
