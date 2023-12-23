import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartProvider>(context).cart;
    // this the another way get data from store;
    // final cart=context.watch<CartProvider>().cart; this is the second way to consume the provider
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "Cart",
            style: Theme.of(context).textTheme.titleLarge,
          )),
        ),
        body: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final cartItem = cart[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                  radius: 27,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Center(
                              child: Text(
                                "Delete Product !",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            content: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  "Are you sure ?",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // context.read<CartProvider>().removeProduct(cartItem);
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .removeProduct(cartItem);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "YES",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 128, 14, 6),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "NO",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 25, 2, 67),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                title: Text(
                  '${cartItem['title']}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text('Size :${cartItem['size']}'),
              );
            }));
  }
}
