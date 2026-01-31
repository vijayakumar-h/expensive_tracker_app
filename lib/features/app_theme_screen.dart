import 'package:expensive_tracker_app/utils/common_exports.dart';

class AppThemeScreen extends StatefulWidget {
  const AppThemeScreen({super.key});

  @override
  State<AppThemeScreen> createState() => _AppThemeScreenState();
}

class _AppThemeScreenState extends State<AppThemeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Theme"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...ThemeMode.values.map(
                    (themeMode) => Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(themeMode.name.toUpperCase()),
                          ),
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () => setState(() => appController
                              .appThemeModeNotifier.value = themeMode),
                          child: Visibility(
                            visible: themeMode ==
                                appController.appThemeModeNotifier.value,
                            replacement: const Icon(Icons.circle_outlined),
                            child: const Icon(
                              color: Colors.green,
                              Icons.check_circle_outline,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
