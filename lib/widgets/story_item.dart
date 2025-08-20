import 'dart:ui';

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
    final borderRadius = BorderRadius.circular(20.0);
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
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
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
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12.0),
              ClipRRect(
                borderRadius: borderRadius,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: story.photoUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              // ClipRRect(
              //   borderRadius: borderRadius,
              //   child: Stack(
              //     children: [
              //       FadeInImage.memoryNetwork(
              //         placeholder: kTransparentImage,
              //         image: story.photoUrl,
              //         fit: BoxFit.cover,
              //         height: 200,
              //         width: double.infinity,
              //       ),
              //       Positioned(
              //         bottom: 0,
              //         left: 0,
              //         right: 0,
              //         child: ClipRect(
              //           child: BackdropFilter(
              //             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              //             child: Container(
              //               height: 40,
              //               width: double.infinity,
              //               decoration: BoxDecoration(
              //                 color: Colors.white.withValues(alpha: 0.3),
              //               ),
              //               child: Padding(
              //                 padding: EdgeInsetsGeometry.all(8.0),
              //                 child: Text(
              //                   story.description,
              //                   textAlign: TextAlign.center,
              //                   style: Theme.of(context).textTheme.bodyMedium!
              //                       .copyWith(fontWeight: FontWeight.bold),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
