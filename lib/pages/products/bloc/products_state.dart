part of 'products_bloc.dart';

class ProductsState {
  final List<Product> products;
  final bool isLoading;

  ProductsState({this.products, this.isLoading = false});

  ProductsState copyWith({List<Product> products, bool isLoading}) =>
      ProductsState(
          products: products ?? this.products,
          isLoading: isLoading ?? this.isLoading);
}
