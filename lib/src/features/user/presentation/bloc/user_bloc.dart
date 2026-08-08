import 'package:expensive_tracker_app/common_exports.dart';

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
