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

class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.qty,
    required this.onAdd,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder image box
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image, size: 40, color: Colors.green),
              ),
            ),
            const SizedBox(height: 8),
            Text(name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text("Rs. $price", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),

            // Yahan asli logic hai: qty == 0 to "Add to Cart" button,
            // warna 1 2 3 wala stepper
            qty == 0
                ? SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D6A4F),
                ),
                child: const Text("Add to Cart",
                    style: TextStyle(color: Colors.white)),
              ),
            )
                : Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2D6A4F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: onDecrement,
                  ),
                  Text("$qty",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: onIncrement,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}