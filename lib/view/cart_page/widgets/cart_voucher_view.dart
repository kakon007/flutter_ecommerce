import 'package:flutter/material.dart';
import 'package:flutter_interview_app/controller/product_page_controller.dart';
import 'package:get/get.dart';

class CartVoucherView extends StatelessWidget {
  CartVoucherView({super.key});
  final ProductPagecontroller _controllerPd = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add a voucher'),
                content: TextField(
                  controller: _controllerPd.textFieldController,
                  decoration: const InputDecoration(hintText: "Add a voucher"),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    child: const Text('Add voucher'),
                    onPressed: () {
                      if (_controllerPd.textFieldController.text.isNotEmpty) {
                        if (_controllerPd.textFieldController.text ==
                            'ECHO13') {
                          _controllerPd.calculatePercentage(
                              _controllerPd.subTotalPrice.value, 5);
                          _controllerPd.calculateSubAndQantityTotalPrice();
                          _controllerPd.textFieldController.clear();
                          Navigator.of(context).pop();
                        } else {
                          Get.snackbar('Faild', "Invalid voucher");
                          _controllerPd.textFieldController.clear();

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
    );
  }
}
