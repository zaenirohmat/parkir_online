import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';
import 'settings.dart';
import 'notifications.dart';

class MainScreen extends StatefulWidget {
  final String username;

  MainScreen({required this.username});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children.addAll([
      SettingsPage(),
      HomePage(username: widget.username),
      NotificationsPage(),
      ProfilePage(),
    ]);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple, // Warna ikon yang dipilih
        unselectedItemColor: Colors.grey, // Warna ikon yang tidak dipilih
        backgroundColor: Colors.white, // Warna latar belakang navigation bar
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah Kendaraan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Cek Kendaraan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
