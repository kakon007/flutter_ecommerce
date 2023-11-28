import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_app/view/cart_page/cart_page_view.dart';
import 'package:flutter_interview_app/view/product_page/product_page_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

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

  int _current = 0;
  final CarouselController _controller = CarouselController();

  Future<int> _calculateTotalPrice() async {
    final box = Boxes.getData();

    List<Product> products = box.values.toList();

    _controllerPd.subTotalPrice.value =
        products.fold(0, (prev, product) => prev + product.price);
    _controllerPd.totalQuantity.value =
        products.fold(0, (prev, product) => prev + 1);
    print(_controllerPd.subTotalPrice.value);
    _controllerPd.calculateTotalPrice();
    return _controllerPd.subTotalPrice.value;
  }

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
                );
                final box = Boxes.getData();
                box.add(data);

                data.save().then((value) {
                  _calculateTotalPrice();
                  return Get.to(() => CartPageView());
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
            child: Icon(Icons.arrow_back)),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => CartPageView());
            },
            child: Padding(
              padding: EdgeInsets.all(20.0),
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
                  CarouselSlider(
                    items: List.generate(
                        _controllerPd.productDetails!.value.images!.length,
                        (index) => Container(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: _controllerPd.productDetails == null
                                        ? SizedBox()
                                        : Image.network(
                                            "${_controllerPd.productDetails?.value.images?[index]}",
                                            fit: BoxFit.cover,
                                            width: 1000.0)),
                              ),
                            )),
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _controllerPd.productDetails!.value.images!
                        .asMap()
                        .entries
                        .map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),

                  //////text///
                  ///
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${_controllerPd.productDetails?.value.title}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 5,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${_controllerPd.productDetails?.value.rating}/5',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Brand',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                      Text('${_controllerPd.productDetails?.value.brand}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Stock',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                      Text('${_controllerPd.productDetails?.value.stock}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400))
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text('Product Details',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                  Text('${_controllerPd.productDetails?.value.description}',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                ]),
        ),
      ),
    );
  }
}
