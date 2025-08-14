import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:story_app/models/story.dart';
import 'package:transparent_image/transparent_image.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.story, required this.onStoryTap});

  final Story story;
  final void Function(Story story) onStoryTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20.0);
    return GestureDetector(
      onTap: () => onStoryTap(story),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Text(
                story.name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(16.0),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Stack(
                  children: [
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: story.photoUrl,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(8.0),
                              child: Text(
                                story.description,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
