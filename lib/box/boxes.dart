import 'package:hive/hive.dart';

import '../model/cart_product_model.dart';

class Boxes {
  static Box<Product> getData() => Hive.box<Product>('product');
}
