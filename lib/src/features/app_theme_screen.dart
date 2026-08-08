import 'package:expensive_tracker_app/src/utils/common_exports.dart';

class AppThemeScreen extends StatelessWidget {
  const AppThemeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Theme"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...ThemeMode.values
                          .where((m) => m != ThemeMode.system)
                          .map(
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
                              onTap: () => context
                                  .read<ThemeBloc>()
                                  .add(ThemeChanged(themeMode)),
                              child: Visibility(
                                visible: themeMode == state.themeMode ||
                                    (state.themeMode == ThemeMode.system &&
                                        ((themeMode == ThemeMode.dark &&
                                                MediaQuery.of(context)
                                                        .platformBrightness ==
                                                    Brightness.dark) ||
                                            (themeMode == ThemeMode.light &&
                                                MediaQuery.of(context)
                                                        .platformBrightness ==
                                                    Brightness.light))),
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
                  );
                },
              ),
            )
          ],
        ),
      );
}
