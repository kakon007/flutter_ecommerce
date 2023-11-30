import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_app/view/cart_page/cart_page_view.dart';
import 'package:flutter_interview_app/controller/product_page_controller.dart';
import 'package:flutter_interview_app/view/product_details_page/widget/product_details_other_widgets.dart';
import 'package:flutter_interview_app/view/product_details_page/widget/product_details_slider_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../box/boxes.dart';
import '../../model/cart_product_model.dart';

class ProductDetailsPageView extends StatefulWidget {
  const ProductDetailsPageView({
    super.key,
  });

  @override
  State<ProductDetailsPageView> createState() => _ProductDetailsPageViewState();
}

class _ProductDetailsPageViewState extends State<ProductDetailsPageView> {
  final ProductPagecontroller _controllerPd = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Price',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                Obx(
                  () => Row(
                    children: [
                      Text('\$ ${_controllerPd.productDetails?.value.price}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                          ' /${_controllerPd.productDetails?.value.discountPercentage}',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                final data = Product(
                    _controllerPd.productDetails!.value.id!,
                    _controllerPd.productDetails!.value.title!,
                    _controllerPd.productDetails!.value.description!,
                    _controllerPd.productDetails!.value.price!,
                    _controllerPd.productDetails!.value.discountPercentage!,
                    _controllerPd.productDetails!.value.rating!,
                    _controllerPd.productDetails!.value.stock!,
                    _controllerPd.productDetails!.value.brand!,
                    _controllerPd.productDetails!.value.category!,
                    _controllerPd.productDetails!.value.thumbnail!,
                    _controllerPd.productDetails!.value.images!,
                    1);
                final box = Boxes.getData();
                box.add(data);
                _controllerPd.getQuantity();
                data.save().then((value) {
                  _controllerPd.calculateSubAndQantityTotalPrice();
                  return Get.to(() => const CartPageView());
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Center(
            child: Text(
          'My cart',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back)),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const CartPageView());
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  const Icon(Icons.shopping_cart),
                  Obx(() => CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Center(
                            child: Text(
                          '${_controllerPd.totalQuantity.value}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        )),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => _controllerPd.isDataLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const ProductDetailsSliderView(),
                  const SizedBox(
                    height: 20,
                  ),
                  ProductDetailsOtherWidgets()
                ]),
        ),
      ),
    );
  }
}
