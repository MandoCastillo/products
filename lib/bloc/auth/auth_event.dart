part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSuccess extends AuthEvent {
  final bool isLogged;
  final String token;
  final String userEmail;

  AuthSuccess({this.isLogged, this.token, this.userEmail});
}
