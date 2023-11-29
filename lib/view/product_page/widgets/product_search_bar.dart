import 'package:flutter/material.dart';
import 'package:flutter_interview_app/controller/product_page_controller.dart';
import 'package:get/get.dart';

class ProductSearchBar extends StatelessWidget {
  ProductSearchBar({super.key});
  final ProductPagecontroller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      decoration: const BoxDecoration(
          color: Color(0xffF2F2F2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
          hintText: 'Search anything',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        onSubmitted: (v) {
          _controller.getAllProductBySearchingData(productName: v);
        },
      ),
    );
  }
}
