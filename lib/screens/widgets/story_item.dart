import 'package:flutter/material.dart';
import 'package:story_app/models/story.dart';
import 'package:story_app/util/date_formatter.dart';
import 'package:transparent_image/transparent_image.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.story, required this.onStoryTap});

  final Story story;
  final void Function(Story story) onStoryTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.0);
    final datePost = DateFormatter().formatDate(story.createdAt.toLocal());
    return GestureDetector(
      onTap: () => onStoryTap(story),
      child: Card(
        elevation: 2.0,
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                story.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                datePost,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                story.description,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12.0),
              Hero(
                tag: story.id,
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: story.photoUrl,
                    fit: BoxFit.cover,
                    height: 190,
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
