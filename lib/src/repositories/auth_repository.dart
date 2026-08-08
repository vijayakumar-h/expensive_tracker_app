import 'package:expensive_tracker_app/src/utils/common_exports.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUp(String name, String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

/// Singletons start here:
/// [MockAuthRepository] is registered as a Lazy Singleton in GetIt.
class MockAuthRepository implements AuthRepository {
  final ApiService? apiService;
  UserModel? _currentUser;

  MockAuthRepository({this.apiService});

  @override
  Future<UserModel> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    _currentUser = UserModel(
      name: 'Vijay Kumar',
      email: email,
      profileImageUrl: 'https://i.pravatar.cc/150?u=$email',
    );
    return _currentUser!;
  }

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = UserModel(
      name: name,
      email: email,
      profileImageUrl: 'https://i.pravatar.cc/150?u=$email',
    );
    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return _currentUser;
  }
}
