import 'package:flutter/material.dart';
import 'package:flutter_interview_app/view/product_details_page/product_details_page_view.dart';
import 'package:flutter_interview_app/controller/product_page_controller.dart';
import 'package:get/get.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ProductPagecontroller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.5,
      child: Obx(
        () => _controller.productList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16),
                children: List.generate(
                  _controller.productList.length,
                  (index) => InkWell(
                    onTap: () {
                      _controller
                          .getIndividualProductData(
                              productid: _controller.productList[index].id)
                          .then((value) =>
                              Get.to(() => const ProductDetailsPageView()));
                    },
                    child: Container(
                      //height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffF2F2F4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Image.network(
                                  '${_controller.productList[index].images?.first.toString()}',
                                  fit: BoxFit.cover,
                                  width: 1000.0),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(
                              '${_controller.productList[index].title}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(
                              '\$ ${_controller.productList[index].price}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
