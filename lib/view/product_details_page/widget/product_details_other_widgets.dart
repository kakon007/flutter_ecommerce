import 'package:flutter/material.dart';
import 'package:flutter_interview_app/controller/product_page_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProductDetailsOtherWidgets extends StatelessWidget {
  ProductDetailsOtherWidgets({super.key});
  final ProductPagecontroller _controllerPd = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${_controllerPd.productDetails?.value.title}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            RatingBar.builder(
              itemSize: 20,
              initialRating: _controllerPd.productDetails?.value.rating ?? 0,
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
                //print(rating);
              },
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '${_controllerPd.productDetails?.value.rating}/5',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Brand',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            Text('${_controllerPd.productDetails?.value.brand}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Stock',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            Text('${_controllerPd.productDetails?.value.stock}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        const Text('Product Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('${_controllerPd.productDetails?.value.description}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
