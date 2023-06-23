import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:testproject/bottomNavPages/Collections.dart';
import 'package:testproject/pages/firstpage.dart';
import 'package:testproject/pages/profilepage.dart';
import 'package:testproject/pages/secondpage.dart';
import 'package:testproject/pages/settingpage.dart';

import 'bottomNavPages/home.dart';
import 'bottomNavPages/qrcode.dart';
import 'bottomNavPages/shop.dart';
import 'maps/map_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    UserCollections(),
    UserQRCode(),
    UserShop(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: const Text('N E T W A S T E'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ), //For Notification Bell Icon
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue[900],
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Center(
                    child: Text(
                      'L O G O',
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.heart_broken,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Broken Heart Page',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FirstPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.medical_information,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'You need MedKit Page',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SecondPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.map_sharp,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'MapPage Page',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MapScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.medical_information,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Settings',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'LogOut',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: signUserOut,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade800,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: GNav(
              onTabChange: _navigateBottomBar,
              selectedIndex: _selectedIndex,
              backgroundColor: Colors.blue.shade800,
              color: Colors.white,
              activeColor: Colors.white,
              gap: 4,
              padding: const EdgeInsets.all(16),
              tabBackgroundColor: Colors.blue,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.payment_outlined,
                  text: 'Payments',
                ),
                GButton(
                  icon: Icons.qr_code,
                  text: 'Scan',
                ),
                GButton(
                  icon: Icons.shopping_bag_outlined,
                  text: 'Shop',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
