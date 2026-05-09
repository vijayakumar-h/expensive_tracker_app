import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final String languageCode;

  const SettingsState({this.languageCode = 'en'});

  @override
  List<Object?> get props => [languageCode];
}
