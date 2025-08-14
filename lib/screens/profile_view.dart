import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/25784574?v=4',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Iconsax.profile_circle),
                  title: Text('Full Name'),
                  subtitle: Text('Vian Rasyid D'),
                ),
                ListTile(
                  leading: Icon(Iconsax.message),
                  title: Text('Email'),
                  subtitle: Text('vianixa34@gmail.com'),
                ),
                ListTile(
                  leading: Icon(Iconsax.link),
                  title: Text('GitHub'),
                  subtitle: Text('@vanard'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
