import 'package:expensive_tracker_app/utils/common_exports.dart';

class InitializerApp extends StatefulWidget {
  const InitializerApp({super.key});

  @override
  State<InitializerApp> createState() => _InitializerAppState();
}

class _InitializerAppState extends State<InitializerApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      Future.delayed(Duration(milliseconds: 800), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Expenses()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text(
          'Loading...',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
