import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productos/bloc/auth/auth_bloc.dart';
import 'package:productos/pages/login/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // print(state);
          if (state.isLogged) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'products', (route) => false);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_EmailInput(), _PasswordInput(), _LoginButton()],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return TextField(
      onChanged: (value) => loginBloc.add(LoginEmailChanged(value)),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return TextField(
      onChanged: (value) => loginBloc.add(LoginPasswordChanged(value)),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<LoginBloc, LoginState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Login'),
                onPressed: state.isValid
                    ? () {
                        loginBloc.add(LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
