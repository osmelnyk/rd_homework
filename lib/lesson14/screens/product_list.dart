import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/cart_notifier.dart';
import '../notifiers/product_notifier.dart';
import 'cart.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            title: const Text('Provider Demo'),
            actions: [
              Row(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart),
                    label: Text(
                      context.watch<CartNotifier>().cart.length.toString(),
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
          body: Consumer<ProductNotifier>(builder: (context, value, _) {
            return ListView(
              children: value.products // using items from within build method
                  .map(
                    (product) => ListTile(
                      title: Text(product.name),
                      subtitle: Text("USD ${product.price}"),
                      trailing: IconButton(
                        icon: Icon(
                          context
                                  .watch<CartNotifier>()
                                  .cart
                                  .map((item) => item.id)
                                  .contains(product.id)
                              ? Icons.add_shopping_cart
                              : Icons.shopping_cart,
                        ),
                        onPressed: () {
                          context.read<CartNotifier>().addToCart(product);
                          setState(() {});
                        },
                      ),
                    ),
                  )
                  .toList(),
            );
          }),
        );
  }
}
