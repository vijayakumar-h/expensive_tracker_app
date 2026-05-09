import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LanguageChanged extends SettingsEvent {
  final String languageCode;
  const LanguageChanged(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}

class LoadSettings extends SettingsEvent {}
