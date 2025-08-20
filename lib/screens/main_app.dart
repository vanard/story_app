import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/providers/main_provider.dart';
import 'package:story_app/screens/add_story_view.dart';
import 'package:story_app/screens/home_view.dart';
import 'package:story_app/screens/profile_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.initialNavIndex, required this.onNavTap});

  final int initialNavIndex;
  final void Function(int index) onNavTap;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<MainProvider>(context, listen: false);
    _provider.onNavigationTap(widget.initialNavIndex, notify: false);
  }

  void _onNavItemTapped(int index) {
    _provider.onNavigationTap(index);
    widget.onNavTap(index);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.selectedNavigationIndex,
        onTap: _onNavItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add Story',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: IndexedStack(
        index: provider.selectedNavigationIndex,
        children: const [
          HomeScreen(),
          AddStoryScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
