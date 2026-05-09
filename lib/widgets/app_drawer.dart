import 'package:expensive_tracker_app/utils/common_exports.dart';
import 'package:expensive_tracker_app/blocs/user/user_bloc.dart';
import 'package:expensive_tracker_app/blocs/user/user_state.dart';
import 'package:expensive_tracker_app/blocs/settings/settings_bloc.dart';
import 'package:expensive_tracker_app/blocs/settings/settings_state.dart';
import 'package:expensive_tracker_app/blocs/settings/settings_event.dart';
import 'package:expensive_tracker_app/features/app_theme_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Drawer(
      child: Column(
        children: [
          // User Header
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: theme.colorScheme.onPrimary,
                  child: Text(
                    state.user.name[0],
                    style: TextStyle(inherit: true, fontSize: 24, fontWeight: FontWeight.bold, color: theme.primaryColor),
                  ),
                ),
                accountName: Text(
                  state.user.name,
                  style: const TextStyle(inherit: true, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(state.user.email),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                ),
              );
            },
          ),
          
          // Drawer Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home_rounded),
                  title: const Text('Dashboard'),
                  onTap: () => Navigator.pop(context),
                ),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    String themeName = context.l10n('light');
                    if (state.themeMode == ThemeMode.dark) {
                      themeName = context.l10n('dark');
                    }
                    if (state.themeMode == ThemeMode.system) {
                      final isDark = MediaQuery.of(context).platformBrightness ==
                          Brightness.dark;
                      themeName =
                          '${context.l10n(isDark ? 'dark' : 'light')} (System)';
                    }

                    return ExpansionTile(
                      leading: const Icon(Icons.palette_rounded),
                      title: Text(context.l10n('theme')),
                      subtitle: Text(themeName),
                      children: [
                        ListTile(
                          title: Text(context.l10n('light')),
                          trailing: state.themeMode == ThemeMode.light
                              ? Icon(Icons.check, color: theme.primaryColor)
                              : null,
                          onTap: () => context
                              .read<ThemeBloc>()
                              .add(const ThemeChanged(ThemeMode.light)),
                        ),
                        ListTile(
                          title: Text(context.l10n('dark')),
                          trailing: state.themeMode == ThemeMode.dark
                              ? Icon(Icons.check, color: theme.primaryColor)
                              : null,
                          onTap: () => context
                              .read<ThemeBloc>()
                              .add(const ThemeChanged(ThemeMode.dark)),
                        ),
                      ],
                    );
                  },
                ),
                
                // Language Selector
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    String languageName = 'English';
                    if (state.languageCode == 'hi') languageName = 'Hindi';
                    if (state.languageCode == 'kn') languageName = 'Kannada';

                    return ExpansionTile(
                      leading: const Icon(Icons.language_rounded),
                      title: Text(context.l10n('language')),
                      subtitle: Text(languageName),
                      children: [
                        ListTile(
                          title: const Text('English'),
                          trailing: state.languageCode == 'en' ? Icon(Icons.check, color: theme.primaryColor) : null,
                          onTap: () => context.read<SettingsBloc>().add(const LanguageChanged('en')),
                        ),
                        ListTile(
                          title: const Text('Hindi (हिंदी)'),
                          trailing: state.languageCode == 'hi' ? Icon(Icons.check, color: theme.primaryColor) : null,
                          onTap: () => context.read<SettingsBloc>().add(const LanguageChanged('hi')),
                        ),
                        ListTile(
                          title: const Text('Kannada (ಕನ್ನಡ)'),
                          trailing: state.languageCode == 'kn' ? Icon(Icons.check, color: theme.primaryColor) : null,
                          onTap: () => context.read<SettingsBloc>().add(const LanguageChanged('kn')),
                        ),
                      ],
                    );
                  },
                ),
                
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: Text(context.l10n('about')),
                  onTap: () {
                    Navigator.pop(context);
                    showAboutDialog(
                      context: context,
                      applicationName: 'Expensive Tracker',
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© 2026 Vijay Kumar',
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                  title: const Text('Logout', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                ),
              ],
            ),
          ),
          
          // Footer
          Padding(
            padding: const EdgeInsets.all(kAppPadding),
            child: Text(
              'v1.0.0',
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
