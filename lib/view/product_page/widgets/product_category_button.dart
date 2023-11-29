import 'package:flutter/material.dart';
import 'package:flutter_interview_app/controller/product_page_controller.dart';
import 'package:get/get.dart';

class ProductCategoryButton extends StatelessWidget {
  ProductCategoryButton({super.key});

  final ProductPagecontroller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 16,
      child: Obx(
        () => _controller.categoriesList.isEmpty
            ? SizedBox()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (c, i) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _controller.selectedIndex.value = i;
                      _controller.getAllProductBySelectingData(
                          productName: _controller.categoriesList[i]);
                    },
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            color: _controller.selectedIndex.value == i
                                ? Colors
                                    .black // Change this to the selected color
                                : const Color(0xffF2F2F2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text('${_controller.categoriesList[i]}',
                              style: TextStyle(
                                  color: _controller.selectedIndex.value == i
                                      ? Colors.white
                                      : Colors.black)),
                        )),
                      ),
                    ),
                  ),
                ),
                itemCount: _controller.categoriesList.length,
              ),
      ),
    );
  }
}
