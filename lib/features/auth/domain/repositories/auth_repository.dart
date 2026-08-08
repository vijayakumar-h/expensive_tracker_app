import '../../../../features/user/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUp(String name, String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}
