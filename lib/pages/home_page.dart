import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/widgets/product_list.dart';
import 'package:shop/providers/cart_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  List<Widget> pages = const [
    ProductList(),
    CartPage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 35,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          currentIndex: currentPage,
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "home",
            ),
           BottomNavigationBarItem(
              icon: Stack(
                children: [
                 const Icon(Icons.shopping_cart),
                  if (cart.isNotEmpty)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding:const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red, // Adjust the color as needed
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints:const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Center(
                          child: Text(
                            '${cart.length}',
                            style:const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              label:
                  'cart', // This will be the tooltip and is optional
            )

          ]),
    );
  }
}
