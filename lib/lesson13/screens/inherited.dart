import 'package:flutter/material.dart';
import '../product_provider.dart';
import 'cart.dart';

class InheritedScreen extends StatefulWidget {
  const InheritedScreen({super.key});

  @override
  State<InheritedScreen> createState() => _InheritedScreenState();
}

class _InheritedScreenState extends State<InheritedScreen> {
  @override
  Widget build(BuildContext context) {
    var products = ProductContainer.of(context).products;
    var cart = ProductContainer.of(context).cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inherited Cart Widget'),
        actions: [
          Row(
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart),
                label: Text(
                  cart.length.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: products
            .map(
              (product) => ListTile(
                title: Text(product.name),
                subtitle: Text("USD ${product.price}"),
                trailing: IconButton(
                  icon: Icon(
                    cart.contains(product)
                        ? Icons.remove_shopping_cart
                        : Icons.add_shopping_cart,
                  ),
                  onPressed: () {
                    // Using cart variable to add/remove item
                    !cart.contains(product)
                        // Add to cart
                        ? ProductContainer.of(context).addToCart(product)
                        // Remove from cart
                        : ProductContainer.of(context).removeFromCart(product);
                    setState(() {});
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
