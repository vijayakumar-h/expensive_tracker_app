import 'package:expensive_tracker_app/common_exports.dart';

abstract class UserLocalDataSource {
  UserModel getUser();
  Future<void> saveUser(UserModel user);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final HiveService hiveService;

  UserLocalDataSourceImpl({required this.hiveService});

  @override
  UserModel getUser() {
    final userMap = hiveService.get('userProfile');
    if (userMap != null) {
      final map = Map<String, dynamic>.from(userMap as Map);
      return UserModel.fromMap(map);
    }
    return const UserModel(name: 'Vijay Kumar', email: 'vijay@example.com');
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await hiveService.store('userProfile', user.toMap());
  }
}
