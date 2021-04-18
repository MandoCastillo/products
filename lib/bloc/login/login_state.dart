part of 'login_bloc.dart';

class LoginState {
  final String email;
  final String password;
  // final String token;
  // final String userEmail;
  final bool isValid;
  final bool isLoading;
  // final bool isLogged;

  LoginState({
    this.email = '',
    this.password = '',
    // this.token = '',
    // this.userEmail = '',
    this.isValid = false,
    this.isLoading = false,
    // this.isLogged = false,
  });

  LoginState copyWith({
    String email,
    String password,
    // String token,
    // String userEmail,
    bool isValid,
    bool isLoading,
    // bool isLogged
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        // token: token ?? this.token,
        // userEmail: userEmail ?? this.userEmail,
        isValid: isValid ?? this.isValid,
        isLoading: isLoading ?? this.isLoading,
        // isLogged: isLogged ?? this.isLogged
      );
}
