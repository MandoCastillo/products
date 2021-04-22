import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:productos/bloc/products/products_bloc.dart';
import 'package:productos/models/product_model.dart';
import 'package:productos/providers/products_provider.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsBloc productsBloc;
  final ProductsProvider _productsProvider = new ProductsProvider();

  ProductBloc({this.productsBloc}) : super(ProductState());

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is SetProduct) {
      yield _mapSetProductToState(event, state);
    } else if (event is ProductNameChanged) {
      yield _mapProductNameChangedToState(event, state);
    } else if (event is ProductAvailableChanged) {
      yield _mapProductAvailableChangedToState(event, state);
    } else if (event is ProductPriceChanged) {
      _mapProductPriceChangedToState(event, state);
    } else if (event is ProductSubmitted) {
      yield* _mapProductSubmittedToState(event, state);
    }
  }

  ProductState _mapSetProductToState(SetProduct event, ProductState state) {
    return state.copyWith(product: event.product);
  }

  ProductState _mapProductNameChangedToState(
      ProductNameChanged event, ProductState state) {
    return state.copyWith(product: state.product.copyWith(title: event.name));
  }

  ProductState _mapProductAvailableChangedToState(
      ProductAvailableChanged event, ProductState state) {
    return state.copyWith(
        product: state.product.copyWith(available: event.available));
  }

  ProductState _mapProductPriceChangedToState(
      ProductPriceChanged event, ProductState state) {
    return state.copyWith(
        product: state.product.copyWith(value: double.parse(event.price)));
  }

  Stream<ProductState> _mapProductSubmittedToState(
      ProductSubmitted event, ProductState state) async* {
    yield state.copyWith(isLoading: true);
    try {
      final response = await _productsProvider.addProduct(state.product);
      // print(response);
      productsBloc.add(AddProduct(response));
      yield state.copyWith(isLoading: false, isFinished: true);
      yield state.copyWith(isFinished: false);
    } catch (e) {
      print(e);
      yield state.copyWith(isLoading: false);
    }
  }
}
