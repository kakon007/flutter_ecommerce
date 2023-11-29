import 'package:flutter/material.dart';
import 'package:flutter_interview_app/box/boxes.dart';
import 'package:flutter_interview_app/model/cart_product_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../controller/product_page_controller.dart';

class CartListView extends StatefulWidget {
  const CartListView({super.key});

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  final ProductPagecontroller _controllerPd = Get.find();

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
    return _controllerPd.subTotalPrice.value;
  }

  Future<void> updateQuantity(int index, int price) async {
    final box = Boxes.getData();
    var product = box.getAt(index);
    if (product != null) {
      product.quantity++;
      _controllerPd.subTotalPrice.value =
          _controllerPd.subTotalPrice.value + price;
      _controllerPd.totalPrice.value = _controllerPd.totalPrice.value + price;

      //_calculateTotalPrice(excludedProductId: index);
      await box.putAt(index, product);
    }
  }

  Future<void> removedQuantity(int index, int price) async {
    final box = Boxes.getData();
    var product = box.getAt(index);
    if (product != null) {
      if (product.quantity < 1) {
        box.deleteAt(index);
      } else {
        product.quantity--;
        _controllerPd.subTotalPrice.value =
            _controllerPd.subTotalPrice.value - price;
        _controllerPd.totalPrice.value = _controllerPd.totalPrice.value - price;
        await box.putAt(index, product);
      }
    }
  }

  void _incrementCounter(
    int index,
    int price,
  ) {
    updateQuantity(index, price);
  }

  void _dcrementCounter(int index, int price) {
    removedQuantity(index, price);
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
                                data[i].images.first.toString(),
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
                                  data[i].title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text('Size L',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                                Text('\$ ${data[i].price}',
                                    style: const TextStyle(
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
                                  _controllerPd
                                      .calculateSubAndQantityTotalPrice();
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
                                      _incrementCounter(i, data[i].price);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Icon(
                                          Icons.add,
                                          size: 15,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${data[i].quantity}',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _dcrementCounter(i, data[i].price);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Icon(
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
