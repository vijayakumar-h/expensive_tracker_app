import 'package:expensive_tracker_app/common_exports.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({required this.localDataSource});

  @override
  UserModel getUser() {
    return localDataSource.getUser();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await localDataSource.saveUser(user);
  }
}
