import 'package:expensive_tracker_app/src/utils/common_exports.dart';

/// 🔴 SHORT-LIVED FEATURE BLoC
/// [UserBloc] handles user profile state management.
/// It receives [AppRepository] via constructor injection (supplied by GetIt `sl<AppRepository>()`).
class UserBloc extends Bloc<UserEvent, UserState> {
  final AppRepository _repository;

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
