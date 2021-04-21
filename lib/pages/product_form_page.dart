import 'package:flutter/material.dart';
import 'package:productos/models/product_model.dart';

class ProductsFormPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Product prodData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('ProductsFormPage'),
      ),
    );
  }
}
