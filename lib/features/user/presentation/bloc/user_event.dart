import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUser extends UserEvent {
  final UserModel user;
  const UpdateUser(this.user);

  @override
  List<Object?> get props => [user];
}

class LoadUser extends UserEvent {}
