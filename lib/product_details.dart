import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map product;

  ProductDetailsScreen({required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product["title"])),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.network(widget.product["thumbnail"], height: 200),
            SizedBox(height: 10),
            Text(
              "Price: \$${widget.product["price"]}",
              style: TextStyle(fontSize: 18),
            ),
            Text("Discount: ${widget.product["discountPercentage"]}%"),
            Text("Rating: ${widget.product["rating"]}"),
            SizedBox(height: 10),
            Text(widget.product["description"]),
            SizedBox(height: 20),
            Text(
              "More Images:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.product["images"].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4),
                    child: Image.network(
                      widget.product["images"][index],
                      width: 100,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
