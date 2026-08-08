import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../models/user_model.dart';

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
