part of 'login_bloc.dart';

class LoginState {
  final String email;
  final String password;
  final bool isValid;
  final bool isLoading;

  LoginState({
    this.email = '',
    this.password = '',
    this.isValid = false,
    this.isLoading = false,
  });

  LoginState copyWith({
    String email,
    String password,
    bool isValid,
    bool isLoading,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        isLoading: isLoading ?? this.isLoading,
      );
}
