import 'package:flutter/material.dart';
import 'package:story_app/data/api_service.dart';
import 'package:story_app/models/list_story.dart';
import 'package:story_app/models/story.dart';

class StoriesProvider extends ChangeNotifier {
  late final ApiService _apiService;
  bool _isLoading = false;
  String _errorMessage = '';
  List<Story>? _listStory;

  StoriesProvider({required ApiService service}) : _apiService = service;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<Story>? get listStory => _listStory;

  Future<void> fetchStories({
    int page = 0,
    int size = 10,
    required String token,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final stories = await _apiService.getStories(page, size, token);
      // debugPrint('Fetched stories: $stories');
      final resData = ListStoryResponse.fromMap(stories);
      debugPrint('Fetched stories: ${resData.listStory.length}');
      _listStory = resData.listStory;
    } catch (e) {
      _errorMessage = e.toString().split('Exception:').last.trim();
      debugPrint('Error fetching stories: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
