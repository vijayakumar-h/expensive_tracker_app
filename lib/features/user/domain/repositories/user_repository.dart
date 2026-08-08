import '../../data/models/user_model.dart';

abstract class UserRepository {
  UserModel getUser();
  Future<void> saveUser(UserModel user);
}
