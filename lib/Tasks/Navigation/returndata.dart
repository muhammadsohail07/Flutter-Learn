import 'package:flutter/material.dart';

class Pizza {
  final String name;
  final String description;
  final double price;
  final IconData icon;

  Pizza({
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });
}

class PizzaHomeScreen extends StatefulWidget {
  const PizzaHomeScreen({super.key});

  @override
  State<PizzaHomeScreen> createState() => _PizzaHomeScreenState();
}

class _PizzaHomeScreenState extends State<PizzaHomeScreen> {
  Pizza? _selectedPizza;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Pizza Selection'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_selectedPizza != null)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.deepOrange.shade100,
                          child: Icon(_selectedPizza!.icon,
                              size: 32, color: Colors.deepOrange),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _selectedPizza!.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _selectedPizza!.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rs: ${_selectedPizza!.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Text(
                  'No pizza selected yet',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final selectedPizza = await Navigator.of(context).push<Pizza>(
                      MaterialPageRoute(
                        builder: (context) => const PizzaSelectionScreen(),
                      ),
                    );
                    if (selectedPizza != null) {
                      setState(() {
                        _selectedPizza = selectedPizza;
                      });
                    }
                  },
                  icon: const Icon(Icons.local_pizza),
                  label: const Text('Select Pizza'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PizzaSelectionScreen extends StatelessWidget {
  const PizzaSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Pizza> pizzas = [
      Pizza(
        name: 'Margherita',
        description: 'Classic tomato, mozzarella & basil',
        price: 8.99,
        icon: Icons.local_pizza,
      ),
      Pizza(
        name: 'Pepperoni',
        description: 'Loaded with spicy pepperoni',
        price: 10.99,
        icon: Icons.local_pizza,
      ),
      Pizza(
        name: 'Vegetarian',
        description: 'Bell peppers, olives & mushrooms',
        price: 9.49,
        icon: Icons.local_pizza,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Select Pizza'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          final pizza = pizzas[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.deepOrange.shade100,
                child: Icon(pizza.icon, color: Colors.deepOrange),
              ),
              title: Text(
                pizza.name,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: Text(pizza.description),
              trailing: Text(
                'Rs: ${pizza.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop(pizza);
              },
            ),
          );
        },
      ),
    );
  }
}