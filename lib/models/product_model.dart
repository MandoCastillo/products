import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product product) => json.encode(product.toJson());

class Product {
  String id;
  String title;
  double value;
  bool available;
  String photoUrl;

  Product({
    this.id,
    this.title = '',
    this.value = 0.0,
    this.available = true,
    this.photoUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        value: json["value"].toDouble(),
        available: json["available"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "title": title,
        "value": value,
        "available": available,
        "photoUrl": photoUrl,
      };

  Product copyWith({
    String id,
    String title,
    double value,
    bool available,
    String photoUrl,
  }) =>
      Product(
          id: id ?? this.id,
          title: title ?? this.title,
          value: value ?? this.value,
          available: available ?? this.available,
          photoUrl: photoUrl ?? this.photoUrl);
}
