import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductNotifier extends ChangeNotifier {
  final List<Product> products = populateProducts();
}
