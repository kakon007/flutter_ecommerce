import 'package:flutter/material.dart';
import 'package:flutter_interview_app/controller/product_page_controller.dart';
import 'package:flutter_interview_app/view/cart_page/widgets/cart_list_view.dart';
import 'package:flutter_interview_app/view/cart_page/widgets/cart_total_amount_view.dart';
import 'package:flutter_interview_app/view/cart_page/widgets/cart_voucher_view.dart';
import 'package:get/get.dart';

class CartPageView extends StatefulWidget {
  const CartPageView({super.key});

  @override
  State<CartPageView> createState() => _CartPageViewState();
}

class _CartPageViewState extends State<CartPageView> {
  final ProductPagecontroller _controllerPd = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text(
            'Confirm',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const CartListView(),
              const SizedBox(height: 10),
              CartVoucherView(),
              const SizedBox(
                height: 24,
              ),
              CartTotalAmountView()
            ],
          ),
        ),
      ),
    );
  }
}
