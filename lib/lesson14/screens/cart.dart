import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../notifiers/cart_notifier.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartNotifier>().cart;
    var total = context.watch<CartNotifier>().totalPrice;

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
                      title: Text(e.product.name),
                      subtitle: Text("USD ${e.product.price}"),
                      trailing: _cartItemButtons(context, e),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Row _cartItemButtons(BuildContext context, Cart e) {
    return Row(
      // We use mainAxisSize: MainAxisSize.min to make
      // the buttons visibe even when there is not enough space
      mainAxisSize: MainAxisSize.min,
      children: [
        // Increment quantity button
        ElevatedButton(
          onPressed: () {
            context.read<CartNotifier>().increment(e.id);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.red,
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        // Show quantity of the product
        Text(
          e.quantity.toString(),
        ),
        // Decrement quantity button
        ElevatedButton(
          onPressed: () {
            context.read<CartNotifier>().decrement(e.id);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.red,
          ),
          child: const Icon(Icons.remove, color: Colors.white),
        ),
        const SizedBox(
          width: 10,
        ),
        // Remove Cart item
        ElevatedButton(
          onPressed: () {
            context.read<CartNotifier>().deleteItem(e.id);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.red,
          ),
          child: const Icon(Icons.remove_shopping_cart, color: Colors.white),
        ),
      ],
    );
  }
}
