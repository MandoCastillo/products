import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productos/bloc/login/login_bloc.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sin datos'),
      ),
      body: Center(
        child: Text('ProductsPage'),
      ),
    );
  }
}
