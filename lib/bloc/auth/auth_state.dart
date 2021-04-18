part of 'auth_bloc.dart';

class AuthState {
  final String token;
  final String userEmail;
  final bool isLogged;

  AuthState({this.token, this.userEmail, this.isLogged});

  AuthState copyWith({String token, String userEmail, bool isLogged}) =>
      new AuthState(
          token: token ?? this.token,
          userEmail: userEmail ?? this.userEmail,
          isLogged: isLogged ?? this.isLogged);
}
