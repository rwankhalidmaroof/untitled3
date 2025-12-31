import "package:http/http.dart" as http show Response, get;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled21/product_details.dart';







class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    final response =
    await http.get(Uri.parse("https://dummyjson.com/products"));
    final data = json.decode(response.body);
    setState(() {
      products = data["products"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          return ListTile(
            leading: Image.network(
              p["thumbnail"],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(p["title"]),
            subtitle: Text(
                "Price: \$${p["price"]} | Discount: ${p["discountPercentage"]}%"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProductDetailsScreen(product: p),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
