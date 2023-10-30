import 'product_model.dart';

class Cart {
  final int id;
  final Product product;
  int quantity;
  Cart({
    required this.id,
    required this.product,
    required this.quantity,
  });
}
