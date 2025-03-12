import 'package:flutter/material.dart';
import 'clothes_grid.dart';
import 'outfits_page.dart';
import 'profile_page.dart';
import 'screens/add_clothing_item/add_clothing_item.dart';
import 'screens/calendar/calendar_page.dart';
import 'services/mock_data_service.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = const [
    ClothesGrid(),
    OutfitsPage(),
    CalendarPage(),
    ProfilePage(),
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? "MY WARDROBE" : 
          _selectedIndex == 1 ? "OUTFITS" : 
          _selectedIndex == 2 ? "CALENDAR" : "PROFILE",
          style: const TextStyle(
            letterSpacing: 2.0,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        actions: [
  if (_selectedIndex == 0 || _selectedIndex == 1)
    IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        if (_selectedIndex == 0) {
          // Launch Add Clothing Item flow
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const AddClothingItemFlow(),
            ),
          );
        } else {
          // Add new outfit (you'll implement this later)
          // For now, you could show a snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Outfit creation coming soon!')),
          );
        }
      },
    ),
  IconButton(
    icon: const Icon(Icons.search),
    onPressed: () {
      // Search functionality
    },
  ),
],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.checkroom_outlined),
              activeIcon: Icon(Icons.checkroom),
              label: 'Clothes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.style_outlined),
              activeIcon: Icon(Icons.style),
              label: 'Outfits',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              activeIcon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.white,
          onTap: _onItemTapped,
          selectedFontSize: 12,
          unselectedFontSize: 12,
        ),
      ),
    );
  }
}
