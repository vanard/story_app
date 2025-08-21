import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/stories_provider.dart';
import 'package:story_app/util/date_formatter.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailStoryScreen extends StatelessWidget {
  const DetailStoryScreen({super.key, required this.storyId});

  final String storyId;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StoriesProvider>(context, listen: false);
    final story = provider.getStoryById(storyId);
    final datePost = DateFormatter().formatDate(story.createdAt.toLocal());

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.detailStory)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: story.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: story.photoUrl,
                  fit: BoxFit.cover,
                  height: 250.0,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  story.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  datePost,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              story.description,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
