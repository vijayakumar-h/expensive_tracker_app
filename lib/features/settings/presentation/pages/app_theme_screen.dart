// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localization.dart';
import '../bloc/theme_bloc.dart';
import '../bloc/theme_event.dart';
import '../bloc/theme_state.dart';

class AppThemeScreen extends StatelessWidget {
  const AppThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n('theme')),
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ListView(
            children: [
              RadioListTile<ThemeMode>(
                title: Text(context.l10n('light')),
                value: ThemeMode.light,
                groupValue: state.themeMode,
                onChanged: (mode) {
                  if (mode != null) {
                    context.read<ThemeBloc>().add(ThemeChanged(mode));
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: Text(context.l10n('dark')),
                value: ThemeMode.dark,
                groupValue: state.themeMode,
                onChanged: (mode) {
                  if (mode != null) {
                    context.read<ThemeBloc>().add(ThemeChanged(mode));
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
