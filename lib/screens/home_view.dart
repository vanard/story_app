import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/models/story.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/providers/overlay_provider.dart';
import 'package:story_app/providers/stories_provider.dart';
import 'package:story_app/routes/page_configuration.dart';
import 'package:story_app/routes/router_helper.dart';
import 'package:story_app/screens/widgets/story_item.dart';
import 'package:story_app/util/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
    final storyProvider = context.read<StoriesProvider>();
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
              context.read<OverlayProvider>().showOverlay(OverlayType.dialog, confirmLogout);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(
        children: [
          if (storyProvider.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: CircularProgressIndicator(),
            ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final story = storyProvider.listStory?[index];
                return StoryItem(story: story!, onStoryTap: _onTapItem);
              },
              itemCount: storyProvider.listStory?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
