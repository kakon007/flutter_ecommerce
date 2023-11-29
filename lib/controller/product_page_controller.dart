import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_interview_app/box/boxes.dart';
import 'package:flutter_interview_app/model/product_details_model.dart';
import 'package:flutter_interview_app/model/product_list_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../model/cart_product_model.dart' as localProductModel;

class ProductPagecontroller extends GetxController {
  RxList<Product> productList = (List<Product>.of([])).obs;
  RxList<dynamic> categoriesList = (List<dynamic>.of([])).obs;
  final Rx<ProductDetailsModel>? productDetails = ProductDetailsModel().obs;
  final TextEditingController textFieldController = TextEditingController();

  RxBool isDataLoading = RxBool(true);

  RxInt selectedIndex = 0.obs;

  RxInt subTotalPrice = 0.obs;

  RxInt totalQuantity = 0.obs;

  RxInt voucherDiscount = 0.obs;

  RxInt totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getAllProductData();
    getAllCategoriesData();
  }

  Future<int> calculateSubAndQantityTotalPrice() async {
    final box = Boxes.getData();

    List<localProductModel.Product> products = box.values.toList();

    subTotalPrice.value =
        products.fold(0, (prev, product) => prev + product.price);
    totalQuantity.value = products.fold(0, (prev, product) => prev + 1);

    calculateTotalPrice();
    return subTotalPrice.value;
  }

  void getQuantity() {
    final box = Boxes.getData();
    final data = box.values.toList().cast<Product>();
    totalQuantity.value = data.length;
  }

  double calculatePercentage(int amount, int percentage) {
    var result = amount * (percentage / 100);
    voucherDiscount.value = result.toInt();
    return amount * (percentage / 100);
  }

  void calculateTotalPrice() {
    totalPrice.value = subTotalPrice.value - voucherDiscount.value;
  }

  Future getAllProductData() async {
    http.Response response = await http.get(Uri.parse(
        'https://dummyjson.com/products?limit=10&skip=0&select=title,price,images'));

    if (response.statusCode == 200) {
      ProductListPage productModelData =
          ProductListPage.fromJson(json.decode(response.body));
      productList.value = productModelData.products!;
    } else {
      Get.snackbar('Error', 'Something went worng');
    }
  }

  Future getAllCategoriesData() async {
    http.Response response =
        await http.get(Uri.parse('https://dummyjson.com/products/categories'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      for (var element in data) {
        categoriesList.add(element);
      }
    } else {
      Get.snackbar('Error', 'Something went worng');
    }
  }

  Future getIndividualProductData({int? productid}) async {
    http.Response response =
        await http.get(Uri.parse('https://dummyjson.com/products/$productid'));

    if (response.statusCode == 200) {
      productDetails?.value =
          ProductDetailsModel.fromJson(json.decode(response.body));
      isDataLoading.value = false;
    } else {
      isDataLoading.value = false;
      Get.snackbar('Error', 'Something went worng');
    }
  }

  Future getAllProductBySelectingData({String? productName}) async {
    http.Response response = await http.get(Uri.parse(
        'https://dummyjson.com/products/category/$productName?limit=3&skip=0&select=title,price,images'));

    if (response.statusCode == 200) {
      ProductListPage productModelData =
          ProductListPage.fromJson(json.decode(response.body));
      productList.value = productModelData.products!;
    } else {
      Get.snackbar('Error', 'Something went worng');
    }
  }

  Future getAllProductBySearchingData({String? productName}) async {
    http.Response response = await http.get(Uri.parse(
        'https://dummyjson.com/products/search?q=$productName&limit=3&skip=0&select=title,price,images'));

    if (response.statusCode == 200) {
      ProductListPage productModelData =
          ProductListPage.fromJson(json.decode(response.body));
      productList.value = productModelData.products!;
    } else {
      Get.snackbar('Error', 'Something went worng');
    }
  }
}
