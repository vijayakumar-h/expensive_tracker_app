import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expensive_tracker_app/repositories/app_repository.dart';
import 'package:expensive_tracker_app/blocs/user/user_event.dart';
import 'package:expensive_tracker_app/blocs/user/user_state.dart';

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
