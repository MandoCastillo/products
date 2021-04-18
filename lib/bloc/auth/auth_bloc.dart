import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthSuccess) {
      yield _mapAuthSuccess(event, state);
    }
  }

  AuthState _mapAuthSuccess(AuthSuccess event, AuthState state) {
    return state.copyWith(
        token: event.token,
        userEmail: event.userEmail,
        isLogged: event.isLogged);
  }
}
