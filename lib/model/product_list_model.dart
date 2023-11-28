// To parse this JSON data, do
//
//     final productListPage = productListPageFromJson(jsonString);

import 'dart:convert';

ProductListPage productListPageFromJson(String str) => ProductListPage.fromJson(json.decode(str));

String productListPageToJson(ProductListPage data) => json.encode(data.toJson());

class ProductListPage {
    List<Product>? products;
    int? total;
    int? skip;
    int? limit;

    ProductListPage({
        this.products,
        this.total,
        this.skip,
        this.limit,
    });

    factory ProductListPage.fromJson(Map<String, dynamic> json) => ProductListPage(
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Product {
    int? id;
    String? title;
    int? price;
    List<String>? images;

    Product({
        this.id,
        this.title,
        this.price,
        this.images,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    };
}
