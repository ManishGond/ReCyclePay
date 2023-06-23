import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Replace with your cart items
    List<CartItem> cartItems = [
      CartItem(
        name: 'Product 1',
        price: 20,
        quantity: 2,
      ),
      CartItem(
        name: 'Product 2',
        price: 15,
        quantity: 1,
      ),
      CartItem(
        name: 'Product 3',
        price: 10,
        quantity: 3,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          CartItem item = cartItems[index];
          return ListTile(
            title: Text(
              item.name,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              'Quantity: ${item.quantity}',
              style: const TextStyle(fontSize: 15),
            ),
            trailing: Text(
              '\$${item.price * item.quantity}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${getTotal(cartItems)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckoutPage(cartItems: cartItems)),
                );
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }

  double getTotal(List<CartItem> cartItems) {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
}

class CartItem {
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class CheckoutPage extends StatelessWidget {
  final List<CartItem> cartItems;

  const CheckoutPage({Key? key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Items:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                CartItem item = cartItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Text('\$${item.price * item.quantity}'),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Place order logic goes here
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Order Placed'),
                    content:
                        const Text('Your order has been placed successfully.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
