class ListStoryResponse {
  final bool error;
  final String message;
  final List<ListStory> listStory;

  ListStoryResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });
}

class ListStory {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final DateTime createdAt;
  final double lat;
  final double lon;

  ListStory({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });
}
