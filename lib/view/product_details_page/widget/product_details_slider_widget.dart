import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_app/controller/product_page_controller.dart';
import 'package:get/get.dart';

class ProductDetailsSliderView extends StatefulWidget {
  const ProductDetailsSliderView({super.key});

  @override
  State<ProductDetailsSliderView> createState() =>
      _ProductDetailsSliderViewState();
}

class _ProductDetailsSliderViewState extends State<ProductDetailsSliderView> {
  final ProductPagecontroller _controllerPd = Get.find();

  final CarouselController _controller = CarouselController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: List.generate(
              _controllerPd.productDetails!.value.images!.length,
              (index) => Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: _controllerPd.productDetails == null
                            ? const SizedBox()
                            : Image.network(
                                "${_controllerPd.productDetails?.value.images?[index]}",
                                fit: BoxFit.cover,
                                width: 1000.0)),
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
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
