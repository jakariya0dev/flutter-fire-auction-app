import 'package:auction_app/pages/auctions_page.dart';
import 'package:auction_app/pages/dashboard_page.dart';
import 'package:auction_app/pages/my_items.dart';
import 'package:auction_app/pages/new_auction_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List _pages = const [DashboardPage(), AuctionsPage(), MyItems()];
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Auctions App'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Colors.deepPurple,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NewAuctionPage()));

            }, child: const Text('Create Auction', style: TextStyle(color: Colors.white),)),
          )
        ],
      ),
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        onTap: (value) {
          _currentPageIndex = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.browse_gallery_outlined), label: 'Auctions Gallery'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Items'),
        ],
      ),
    );
  }
}
