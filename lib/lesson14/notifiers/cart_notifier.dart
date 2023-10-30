import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartNotifier extends ChangeNotifier {
  final List<Cart> _cart = [];
  double get totalPrice => getTotalPrice();

  List<Cart> get cart => _cart;

  void addToCart(Product p) {
    var contain = _cart.where((element) => element.product.id == p.id);
    if (contain.isEmpty) {
      _cart.add(Cart(id: p.id, product: p, quantity: 1));
    } else {
      contain.first.quantity += 1;
    }
    notifyListeners();
  }

  void deleteItem(int id) {
    _cart.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void increment(int id) {
    Cart item = _cart.where((element) => element.id == id).first;
    item.quantity++;
    notifyListeners();
  }

  void decrement(int id) {
    Cart item = _cart.where((element) => element.id == id).first;

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _cart.remove(item);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double p = 0;
    for (var element in cart) {
      p += element.product.price * element.quantity;
    }
    return p;
  }
}
