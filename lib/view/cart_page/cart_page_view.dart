import 'package:flutter/material.dart';
import 'package:flutter_interview_app/view/cart_page/widgets/cart_list_view.dart';
import 'package:flutter_interview_app/view/product_page/product_page_controller.dart';
import 'package:get/get.dart';

class CartPageView extends StatefulWidget {
  const CartPageView({super.key});

  @override
  State<CartPageView> createState() => _CartPageViewState();
}

class _CartPageViewState extends State<CartPageView> {
  final ProductPagecontroller _controllerPd = Get.find();
  TextEditingController _textFieldController = TextEditingController();
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
              Get.to(() => CartPageView());
            },
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Icon(Icons.shopping_cart),
                  Obx(() => CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Center(
                            child: Text(
                          '${_controllerPd.totalQuantity.value}',
                          style: TextStyle(fontSize: 12, color: Colors.white),
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
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Add a voucher'),
                          content: TextField(
                            controller: _textFieldController,
                            decoration: const InputDecoration(
                                hintText: "Add a voucher"),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              color: const Color.fromRGBO(76, 175, 80, 1),
                              textColor: Colors.white,
                              child: const Text('Add'),
                              onPressed: () {
                                if (_textFieldController.text.isNotEmpty) {
                                  if (_textFieldController.text == 'ECHO13') {
                                    _controllerPd.calculatePercentage(
                                        _controllerPd.subTotalPrice.value, 5);
                                    _controllerPd.calculateTotalPrice();
                                    Navigator.of(context).pop();
                                  } else {
                                    Navigator.of(context).pop();
                                  }
                                }
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  //height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xffF2F2F2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Add a voucher',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sub total',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  Obx(
                    () => Text('${_controllerPd.subTotalPrice.value}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  )
                ],
              ),
              _controllerPd.voucherDiscount.value == 0
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Voucher discount',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        Obx(
                          () => Text(' ${_controllerPd.voucherDiscount.value}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
              const Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  Obx(
                    () => Text('${_controllerPd.totalPrice.value}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
