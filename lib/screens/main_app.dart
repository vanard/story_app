import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/providers/main_provider.dart';
import 'package:story_app/routes/page_configuration.dart';
import 'package:story_app/routes/router_helper.dart';
import 'package:story_app/screens/add_story_view.dart';
import 'package:story_app/screens/home_view.dart';
import 'package:story_app/screens/profile_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.selectedNavigationIndex,
        onTap: (int index) {
          provider.onNavigationTap(index);
          switch (index) {
            case 0:
              // context.replaceWith(HomePageConfiguration());
              HomeScreen();
              break;
            case 1:
              // context.replaceWith(AddNewStoryPageConfiguration());
              AddStoryScreen();
              break;
            case 2:
              // context.replaceWith(ProfilePageConfiguration());
              ProfileScreen();
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add Story',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
