part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class SetProduct extends ProductEvent {
  final Product product;

  SetProduct(this.product);
}

class ProductNameChanged extends ProductEvent {
  final String name;

  ProductNameChanged(this.name);
}

class ProductPriceChanged extends ProductEvent {
  final String price;

  ProductPriceChanged(this.price);
}

class ProductAvailableChanged extends ProductEvent {
  final bool available;

  ProductAvailableChanged(this.available);
}

class ProductSubmitted extends ProductEvent {}
