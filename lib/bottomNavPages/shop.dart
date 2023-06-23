import 'package:flutter/material.dart';
import 'package:testproject/pages/cartpage.dart';
import 'dart:math';

class UserShop extends StatefulWidget {
  const UserShop({Key? key});

  @override
  _UserShopState createState() => _UserShopState();
}

class _UserShopState extends State<UserShop> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<ShopItem> shopItems = [
    ShopItem(
      imageUrl: 'assets/shoplogo/valLogo.png',
      name: 'Valorant 1000 Points',
      price: '\$20',
    ),
    ShopItem(
      imageUrl: 'assets/shoplogo/swiggyLogo.png',
      name: '15% off on Selected Products',
      price: '\$25',
    ),
    ShopItem(
      imageUrl: 'assets/shoplogo/zomatoLogo.png',
      name: '35% off on Wow Momos!',
      price: '\$15',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: GridView.count(
          crossAxisCount: 2,
          children:
              shopItems.map((item) => ShopItemWidget(item: item)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> _refreshData() async {
    // Shuffle the shop items
    setState(() {
      shopItems.shuffle(Random());
    });

    // Simulate a delay for demonstration purposes
    await Future.delayed(Duration(seconds: 2));
  }
}

class ShopItem {
  final String imageUrl;
  final String name;
  final String price;

  ShopItem({
    required this.imageUrl,
    required this.name,
    required this.price,
  });
}

class ShopItemWidget extends StatelessWidget {
  final ShopItem item;

  const ShopItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle item selection
      },
      child: Card(
        child: Column(
          children: [
            Image.asset(
              item.imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                item.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Text(
              item.price,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
