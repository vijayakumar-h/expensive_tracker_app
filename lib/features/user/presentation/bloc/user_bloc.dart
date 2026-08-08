import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

/// 🔴 FEATURE-SCOPED BLoC
/// [UserBloc] handles user profile state management, receiving [UserRepository] interface.
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;

  UserBloc(this._repository) : super(const UserState()) {
    on<LoadUser>((event, emit) {
      final user = _repository.getUser();
      emit(UserState(user: user));
    });

    on<UpdateUser>((event, emit) async {
      await _repository.saveUser(event.user);
      emit(UserState(user: event.user));
    });
  }
}
