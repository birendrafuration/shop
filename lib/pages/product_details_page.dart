import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  void onTap() {
    Provider.of<CartProvider>(context, listen: false).addProduct({
      'id': widget.product['id'],
      'title': widget.product['title'],
      'price': widget.product['price'],
      'imageUrl': widget.product['imageUrl'],
      'company': widget.product['company'],
      'size': selectedSize,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product added successfuly'),
      ),
    );
  }

  late int selectedSize;
  @override
  void initState() {
    super.initState();
    selectedSize = (widget.product['sizes'] as List<int>)[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("details")),
      ),
      body: Column(children: [
        Text(
          widget.product['title'] as String,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Image.asset(
              widget.product['imageUrl'] as String,
              height: 200,
            ),
          ),
        ),
        Container(
          height: 250,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\$ ${widget.product['price']}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size =
                          (widget.product['sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Chip(
                            label: Text('$size'),
                            backgroundColor: selectedSize == size
                                ? Theme.of(context).colorScheme.primary
                                : const Color.fromRGBO(245, 247, 249, 1),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: const Size(350, 50)),
                  child: Text(
                    "Add To Cart",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
