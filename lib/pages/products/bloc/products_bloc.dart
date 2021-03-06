import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:productos/models/product_model.dart';
import 'package:productos/providers/products_provider.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsState());

  final ProductsProvider _productsProvider = new ProductsProvider();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is GetProducts) {
      yield* _mapProductsGetProducts(event, state);
    } else if (event is AddProduct) {
      yield _mapProductsAddProduct(event, state);
    } else if (event is UpdateProduct) {
      yield _mapProductsUpdateProduct(event, state);
    } else if (event is DeleteProduct) {
      yield* _mapProductsDeleteProduct(event, state);
    }
  }

  Stream<ProductsState> _mapProductsGetProducts(
      ProductsEvent event, ProductsState state) async* {
    yield state.copyWith(isLoading: true);
    try {
      final response = await _productsProvider.getProducts();
      yield state.copyWith(products: response, isLoading: false);
    } catch (e) {
      print(e);
      yield state.copyWith(isLoading: false);
    }
  }

  ProductsState _mapProductsAddProduct(AddProduct event, ProductsState state) {
    return state.copyWith(products: [...state.products, event.product]);
  }

  ProductsState _mapProductsUpdateProduct(
      UpdateProduct event, ProductsState state) {
    return state.copyWith(
        products: state.products
            .map((product) =>
                product.id == event.product.id ? event.product : product)
            .toList());
  }

  Stream<ProductsState> _mapProductsDeleteProduct(
      DeleteProduct event, ProductsState state) async* {
    try {
      final res = await _productsProvider.deleteProduct(event.id);
      if (res) {
        yield state.copyWith(
            products: state.products
                .where((product) => product.id != event.id)
                .toList());
      }
    } catch (e) {}
  }
}
