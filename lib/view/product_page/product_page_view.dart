import 'package:flutter/material.dart';
import 'package:flutter_interview_app/view/cart_page/cart_page_view.dart';
import 'package:flutter_interview_app/view/product_page/product_page_controller.dart';
import 'package:flutter_interview_app/view/product_page/widgets/product_category_button.dart';
import 'package:flutter_interview_app/view/product_page/widgets/product_list_view.dart';
import 'package:flutter_interview_app/view/product_page/widgets/product_search_bar.dart';
import 'package:get/get.dart';

class ProductPageView extends StatefulWidget {
  const ProductPageView({super.key});

  @override
  State<ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<ProductPageView> {
  final ProductPagecontroller _controller = Get.put(ProductPagecontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Echologyx',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => CartPageView());
            },
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Icon(Icons.shopping_cart),
                  Obx(
                    () => CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Center(
                          child: Text(
                        '${_controller.totalQuantity.value}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductSearchBar(),
              SizedBox(
                height: 20,
              ),
              ProductCategoryButton(),
              SizedBox(
                height: 20,
              ),
              ProductListView()
            ],
          ),
        ),
      ),
    );
  }
}
