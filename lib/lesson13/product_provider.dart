import 'package:flutter/material.dart';

import 'model/model.dart';

class ProductProvider extends StatefulWidget {
  final Widget child;
  const ProductProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductProviderState();
}

class ProductProviderState extends State<ProductProvider> {
  final List<Product> _products = populateProducts();
  final List<Product> _cart = [];

  List<Product> get products => _products;
  List<Product> get cart => _cart;

  void addToCart(Product product) {
    setState(() {
      _cart.add(product);
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      _cart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProductContainer(
      data: this,
      child: widget.child,
    );
  }
}

class ProductContainer extends InheritedWidget {
  final ProductProviderState data;

  const ProductContainer({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  static ProductProviderState of(BuildContext context) {
    final ProductProviderState result =
        context.dependOnInheritedWidgetOfExactType<ProductContainer>()!.data;
    return result;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => child != oldWidget;
}
