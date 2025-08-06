class StoryResponse {
  final bool error;
  final String message;
  final Story story;

  StoryResponse({
    required this.error,
    required this.message,
    required this.story,
  });
}

class Story {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final DateTime createdAt;
  final double lat;
  final double lon;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });
}
