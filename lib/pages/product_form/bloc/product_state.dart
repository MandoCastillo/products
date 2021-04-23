part of 'product_bloc.dart';

class ProductState {
  final Product product;
  final bool isLoading;
  final bool isValid;
  final bool isFinished;

  ProductState(
      {this.product,
      this.isLoading = false,
      this.isValid,
      this.isFinished = false});

  ProductState copyWith(
          {Product product, bool isLoading, bool isValid, bool isFinished}) =>
      ProductState(
          product: product ?? this.product,
          isLoading: isLoading ?? this.isLoading,
          isValid: isValid ?? this.isValid,
          isFinished: isFinished ?? this.isFinished);
}
