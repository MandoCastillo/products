import 'package:flutter/material.dart';
import 'package:productos/pages/products/widgets/products_list.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sin datos'),
      ),
      body: ProductsList(),
      floatingActionButton: _FabAddProduct(),
    );
  }
}

class _FabAddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, 'products-form');
      },
      child: Icon(Icons.add),
    );
  }
}
