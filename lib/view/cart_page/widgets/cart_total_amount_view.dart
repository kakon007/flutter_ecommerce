import 'package:flutter/material.dart';
import 'package:flutter_interview_app/controller/product_page_controller.dart';
import 'package:get/get.dart';

class CartTotalAmountView extends StatelessWidget {
  CartTotalAmountView({super.key});
  final ProductPagecontroller _controllerPd = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Sub total',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            Obx(
              () => Text('\$ ${_controllerPd.subTotalPrice.value}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400)),
            )
          ],
        ),
        Obx(
          () => _controllerPd.voucherDiscount.value == 0
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Voucher discount',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                    Text('\$ - ${_controllerPd.voucherDiscount.value}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ],
                ),
        ),
        const Divider(
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            Obx(
              () => Text('\$ ${_controllerPd.totalPrice.value}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400)),
            )
          ],
        ),
      ],
    );
  }
}
