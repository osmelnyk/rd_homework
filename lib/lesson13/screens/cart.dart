import 'package:flutter/material.dart';
import '../product_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cart = ProductContainer.of(context).cart;
    var total = cart.fold(0, (sum, e) => sum + e.price);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your cart (${cart.length})"),
      ),
      body: Column(
        children: [
          Text("Total: USD $total"),
          Expanded(
            child: ListView(
              children: cart
                  .map(
                    (e) => ListTile(
                      title: Text(e.name),
                      subtitle: Text("USD ${e.price}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          ProductContainer.of(context).removeFromCart(e);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
