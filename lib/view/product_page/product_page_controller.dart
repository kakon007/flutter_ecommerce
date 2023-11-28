import 'dart:convert';

import 'package:flutter_interview_app/model/product_details_model.dart';
import 'package:flutter_interview_app/model/product_list_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductPagecontroller extends GetxController {
  RxList<Product> productList = (List<Product>.of([])).obs;
  RxList<dynamic> categoriesList = (List<dynamic>.of([])).obs;
  final Rx<ProductDetailsModel>? productDetails = ProductDetailsModel().obs;

  RxBool isDataLoading = RxBool(true);

  RxInt selectedIndex = 0.obs;

  RxInt subTotalPrice = 0.obs;

  RxInt totalQuantity = 0.obs;

  RxInt voucherDiscount = 0.obs;

  RxInt totalPrice = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllProductData();
    getAllCategoriesData();
  }

  double calculatePercentage(int amount, int percentage) {
    var result = amount * (percentage / 100);
    voucherDiscount.value = result.toInt();
    return amount * (percentage / 100);
  }

  void calculateTotalPrice() {
    totalPrice.value = subTotalPrice.value - voucherDiscount.value;
    print(totalPrice.value);
  }

  Future getAllProductData() async {
    http.Response response = await http.get(Uri.parse(
        'https://dummyjson.com/products?limit=10&skip=0&select=title,price,images'));

    if (response.statusCode == 200) {
      ProductListPage productModelData =
          ProductListPage.fromJson(json.decode(response.body));
      productList.value = productModelData.products!;
      //print('pro le ${productList.length}');
    } else {
      //print('Something went worng');
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
      //print('pro ca ${categoriesList.length}');
    } else {
      //print('Something went worng');
    }
  }

  Future getIndividualProductData({int? productid}) async {
    http.Response response =
        await http.get(Uri.parse('https://dummyjson.com/products/$productid'));

    if (response.statusCode == 200) {
      productDetails?.value =
          ProductDetailsModel.fromJson(json.decode(response.body));
      //print('pro de ${productDetails?.value.category}');
      isDataLoading.value = false;
    } else {
      isDataLoading.value = false;
      //print('Something went worng');
    }
  }

  Future getAllProductBySelectingData({String? productName}) async {
    http.Response response = await http.get(Uri.parse(
        'https://dummyjson.com/products/category/$productName?limit=3&skip=0&select=title,price,images'));

    if (response.statusCode == 200) {
      ProductListPage productModelData =
          ProductListPage.fromJson(json.decode(response.body));
      productList.value = productModelData.products!;
      //print('pro le ${productList.length}');
    } else {
      //print('Something went worng');
    }
  }

  Future getAllProductBySearchingData({String? productName}) async {
    http.Response response = await http.get(Uri.parse(
        'https://dummyjson.com/products/search?q=$productName&limit=3&skip=0&select=title,price,images'));

    if (response.statusCode == 200) {
      ProductListPage productModelData =
          ProductListPage.fromJson(json.decode(response.body));
      productList.value = productModelData.products!;
      //print('pro le ${productList.length}');
    } else {
      //print('Something went worng');
    }
  }
}
