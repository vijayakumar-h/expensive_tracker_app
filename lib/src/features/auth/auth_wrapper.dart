import 'package:expensive_tracker_app/src/utils/common_exports.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const Expenses(); // Assuming Expenses is the main home screen
        } else if (state is Unauthenticated || state is AuthError) {
          return const LoginScreen();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
