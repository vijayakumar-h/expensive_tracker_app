import 'package:equatable/equatable.dart';
import 'package:expensive_tracker_app/models/user_model.dart';

class UserState extends Equatable {
  final UserModel user;

  const UserState({
    this.user = const UserModel(name: 'Vijay Kumar', email: 'vijay@example.com'),
  });

  @override
  List<Object?> get props => [user];
}
