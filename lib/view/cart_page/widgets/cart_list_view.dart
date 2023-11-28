import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_interview_app/box/boxes.dart';
import 'package:flutter_interview_app/model/cart_product_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../product_page/product_page_controller.dart';

class CartListView extends StatefulWidget {
  const CartListView({super.key});

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  final ProductPagecontroller _controllerPd = Get.find();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _dcrementCounter() {
    setState(() {
      _counter--;
    });
  }

  Future<int> _calculateTotalPrice({int? excludedProductId}) async {
    final box = Boxes.getData();

    if (excludedProductId != null) {
      box.deleteAt(excludedProductId);
    }

    List<Product> products = box.values.toList();

    _controllerPd.subTotalPrice.value =
        products.fold(0, (prev, product) => prev + product.price);
    _controllerPd.totalQuantity.value =
        products.fold(0, (prev, product) => prev - 1);
    print(_controllerPd.subTotalPrice.value);
    return _controllerPd.subTotalPrice.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: ValueListenableBuilder<Box<Product>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            final data = box.values.toList().cast<Product>();
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (c, i) => Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF2F2F4)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade100),
                              child: Image.network(
                                '${data[i].images.first.toString()}',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data[i].title}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Size L',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                                Text('${data[i].price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  // box.deleteAt(i);
                                  _calculateTotalPrice(excludedProductId: i);
                                  _controllerPd.voucherDiscount.value = 0;
                                  _controllerPd.calculateTotalPrice();
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _incrementCounter();
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '$_counter',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _dcrementCounter();
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Icon(
                                          Icons.remove,
                                          size: 15,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                    )),
              ),
              itemCount: box.length,
            );
          }),
    );
  }
}
