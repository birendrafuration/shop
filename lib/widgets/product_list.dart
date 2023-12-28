import 'package:flutter/material.dart';
import 'package:shop/global_variables.dart';
import 'package:shop/widgets/product_card.dart';
import 'package:shop/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Addidas', 'Nike', 'Bata'];
  late String selectedFilter;
  var productList = products;
  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    productList = products;
  }

  void filterProducts(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        productList = selectedFilter == "All"
            ? products
            : products
                .where((element) =>
                    element['company'].toString().toLowerCase() ==
                    selectedFilter.toLowerCase())
                .toList();
      } else {
        productList = products
            .where((element) => element['company']
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController textEditingController = TextEditingController();
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Shoes\nCollections",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  onSubmitted: (value) {
                    filterProducts(value);
                    // print(value);
                  },
                  decoration: const InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        size: 32,
                      ),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                        productList = selectedFilter == "All"
                            ? products
                            : products
                                .where((element) =>
                                    element['company']
                                        .toString()
                                        .toLowerCase() ==
                                    selectedFilter.toLowerCase())
                                .toList();
                      });
                    },
                    child: Chip(
                      side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1)),
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      label: Text(filter),
                      labelStyle: const TextStyle(fontSize: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: size.width > 650
                ? GridView.builder(
                    itemCount: productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final product = productList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProductDetailsPage(product: product);
                          }));
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundColor: index.isEven
                              ? const Color.fromRGBO(216, 240, 253, 1)
                              : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    })
                : ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final product = productList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProductDetailsPage(product: product);
                          }));
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundColor: index.isEven
                              ? const Color.fromRGBO(216, 240, 253, 1)
                              : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    }),
          )
        ],
      ),
    );
  }
}
