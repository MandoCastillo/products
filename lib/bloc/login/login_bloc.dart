import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:productos/bloc/auth/auth_bloc.dart';
import 'package:productos/providers/auth_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authBloc;

  LoginBloc({this.authBloc}) : super(LoginState());

  final authProvider = new AuthProvider();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapEmailChangedToState(
      LoginEmailChanged event, LoginState state) {
    final isValid = state.password.length > 4 && event.email.length > 4;
    return state.copyWith(email: event.email, isValid: isValid);
  }

  LoginState _mapPasswordChangedToState(
      LoginPasswordChanged event, LoginState state) {
    final isValid = state.email.length > 4 && event.password.length > 4;
    return state.copyWith(password: event.password, isValid: isValid);
  }

  Stream<LoginState> _mapLoginSubmittedToState(
      LoginSubmitted event, LoginState state) async* {
    yield state.copyWith(isLoading: true);
    try {
      final response = await authProvider.login(state.email, state.password);
      // print(response['ok']);
      // print(response['token'] ?? response['message']);
      if (response['ok']) {
        yield state.copyWith(
            isLoading: false,
            // isLogged: response['ok'],
            // token: response['token'],
            // userEmail: response['email'],
            email: '',
            password: '',
            isValid: false);
        this.authBloc.add(AuthSuccess(
            isLogged: true,
            token: response['token'],
            userEmail: response['email']));
      } else {
        yield state.copyWith(
          isLoading: false,
          // isLogged: response['ok']
        );
      }
    } catch (e) {
      print(e);
      yield state.copyWith(isLoading: false);
    }
  }
}
