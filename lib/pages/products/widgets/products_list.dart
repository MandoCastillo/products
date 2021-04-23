import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:productos/models/product_model.dart';
import 'package:productos/pages/product_form/bloc/product_bloc.dart';
import 'package:productos/pages/products/bloc/products_bloc.dart';

part 'products_list_item.dart';

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    if (productsBloc.state.products == null) {
      productsBloc.add(GetProducts());
    }
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.products?.length == 0) {
          return Text('No hay datos');
        }

        return ListView.builder(
          itemCount: state.products?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ProductsListItem(state.products[index]);
          },
        );
      },
    );
  }
}
