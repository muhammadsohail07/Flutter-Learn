import 'package:flutter/material.dart';

class NamedRoute extends StatelessWidget {
  const NamedRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeProductScreen(),
        '/product': (context) => const ProductScreen(),
      },
    );
  }
}
class product{
  String name;
  int Price;
  String Description;
  product({required this.name,required this.Price,required this.Description,});
}

class HomeProductScreen extends StatelessWidget {
  const HomeProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<product> products = [
    product(name: 'apple', Price: 700 , Description: 'Apples ')
    ];
    return Scaffold(
    appBar: AppBar(
      title: const Text("product"),

    ),
      body: ListView.builder(
          itemCount: products.length,
          padding: EdgeInsets.all(0.8),
          itemBuilder: (context, index){
          final product=products[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21)

            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: EdgeInsets.all(21),
                leading: CircleAvatar(
                  radius: 21,
                  backgroundColor: Colors.green.shade100,
                  child: Text(product.name,   style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
                title: Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                subtitle: Text('\$${product.Price.toStringAsFixed(2)}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pushNamed(context, '/product', arguments: product);
                },
              ),
          );

          }),
    );
  }
}
