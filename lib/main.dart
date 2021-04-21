import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productos/bloc/auth/auth_bloc.dart';
import 'package:productos/bloc/login/login_bloc.dart';
import 'package:productos/bloc/products/products_bloc.dart';
import 'package:productos/pages/login_page.dart';
import 'package:productos/pages/product_form_page.dart';
import 'package:productos/pages/products_page.dart';
import 'package:productos/share_prefs/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(
        create: (BuildContext context) => new AuthBloc(),
      ),
      BlocProvider<LoginBloc>(
        create: (BuildContext context) =>
            new LoginBloc(authBloc: BlocProvider.of<AuthBloc>(context)),
      ),
      BlocProvider<ProductsBloc>(
        create: (BuildContext context) => new ProductsBloc(),
      ),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'products': (_) => ProductsPage(),
        'products-form': (_) => ProductsFormPage(),
      },
    );
  }
}
