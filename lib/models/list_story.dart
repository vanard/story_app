import 'dart:convert';

import 'package:story_app/models/story.dart';

class ListStoryResponse {
  final bool error;
  final String message;
  final List<Story> listStory;

  ListStoryResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'message': message,
      'listStory': listStory.map((x) => x.toMap()).toList(),
    };
  }

  factory ListStoryResponse.fromMap(Map<String, dynamic> map) {
    return ListStoryResponse(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
      listStory: List<Story>.from(
        map['listStory']?.map((x) => Story.fromMap(x)) ?? [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListStoryResponse.fromJson(String source) =>
      ListStoryResponse.fromMap(json.decode(source));
}
