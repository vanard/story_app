import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/models/story.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/providers/stories_provider.dart';
import 'package:story_app/routes/page_configuration.dart';
import 'package:story_app/routes/router_helper.dart';
import 'package:story_app/widgets/story_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    final storyProvider = Provider.of<StoriesProvider>(context, listen: false);
    _authProvider
        .getLoginUser()
        .then((_) async {
          debugPrint('User fetched successfully');
          await storyProvider.fetchStories(
            token: _authProvider.loginUser?.token ?? '',
          );
        })
        .catchError((error) {
          debugPrint('Error fetching user: $error');
        });
  }

  void _logout() async {
    await _authProvider.logout();
    if (!mounted) return;
    context.clearAndPushTo(LoginPageConfiguration());
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.logoutButton),
          content: Text(AppLocalizations.of(context)!.areYouSure),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: _logout,
              child: Text(AppLocalizations.of(context)!.logoutButton),
            ),
          ],
        );
      },
    );
  }

  void _onTapItem(Story story) {
    debugPrint('Tapped on story: ${story.name}');
    context.pushTo(DetailStoryPageConfiguration(story.id));
  }

  @override
  Widget build(BuildContext context) {
    final storyProvider = Provider.of<StoriesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleAppBar),
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutDialog();
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body:
          // Column(
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     Text('Welcome to the Home Screen!'),
          //     Expanded(
          //       child: ListView.builder(
          //         itemBuilder: (context, index) {
          //           final story = storyProvider.listStory?[index];
          //           return StoryItem(story: story!);
          //         },
          //         itemCount: storyProvider.listStory?.length ?? 0,
          //       ),
          //     ),
          //   ],
          // ),
          ListView.builder(
            itemBuilder: (context, index) {
              final story = storyProvider.listStory?[index];
              return StoryItem(story: story!, onStoryTap: _onTapItem);
            },
            itemCount: storyProvider.listStory?.length ?? 0,
          ),
    );
  }
}
