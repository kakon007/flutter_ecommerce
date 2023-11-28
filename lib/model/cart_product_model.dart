import 'package:hive/hive.dart';

part 'cart_product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int price;

  @HiveField(4)
  final double discountPercentage;

  @HiveField(5)
  final double rating;

  @HiveField(6)
  final int stock;

  @HiveField(7)
  final String brand;

  @HiveField(8)
  final String category;

  @HiveField(9)
  final String thumbnail;

  @HiveField(10)
  final List<String> images;

  Product(
      this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'],
      json['title'],
      json['description'],
      json['price'],
      json['discountPercentage'],
      json['rating'],
      json['stock'],
      json['brand'],
      json['category'],
      json['thumbnail'],
      List<String>.from(json['images']),
    );
  }
}
