import 'package:flutter/material.dart';


class AtcHomeScreen extends StatefulWidget {
  const AtcHomeScreen({super.key});

  @override
  State<AtcHomeScreen> createState() => _AtcHomeScreenState();
}

class _AtcHomeScreenState extends State<AtcHomeScreen> {
  // Dummy products list
  final List<Map<String, dynamic>> products = [
    {"name": "Organic Apples", "price": 250, "qty": 0},
    {"name": "Fresh Honey", "price": 600, "qty": 0},
    {"name": "Walnuts", "price": 900, "qty": 0},
  ];

  int get totalCartItems =>
      products.fold(0, (sum, item) => sum + (item["qty"] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GBIANS Store"),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart),
              ),
              if (totalCartItems > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "$totalCartItems",
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return ProductCard(
            name: products[index]["name"],
            price: products[index]["price"],
            qty: products[index]["qty"],
            onAdd: () {
              setState(() => products[index]["qty"] = 1);
            },
            onIncrement: () {
              setState(() => products[index]["qty"]++);
            },
            onDecrement: () {
              setState(() {
                if (products[index]["qty"] > 0) products[index]["qty"]--;
              });
            },
          );
        },
      ),
    );
  }
}

