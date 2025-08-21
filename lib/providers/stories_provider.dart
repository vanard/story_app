import 'dart:io';

import 'package:flutter/material.dart';
import 'package:story_app/data/api_service.dart';
import 'package:story_app/models/list_story.dart';
import 'package:story_app/models/story.dart';

class StoriesProvider extends ChangeNotifier {
  late final ApiService _apiService;
  bool _isLoading = false;
  String _errorMessage = '';
  List<Story>? _listStory;
  File? _selectedImage;

  StoriesProvider({required ApiService service}) : _apiService = service;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<Story>? get listStory => _listStory;
  File? get selectedImage => _selectedImage;

  void setSelectedImage(File? image) {
    _selectedImage = image;
    notifyListeners();
  }

  Future<void> getImageFileSize(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      final int bytes = await file.length();

      final double kb = bytes / 1024;
      final double mb = kb / 1024;

      debugPrint('File size: $bytes bytes');
      debugPrint('File size: ${kb.toStringAsFixed(2)} KB');
      debugPrint('File size: ${mb.toStringAsFixed(2)} MB');
    } else {
      debugPrint('File does not exist.');
    }
  }

  Story getStoryById(String id) {
    if (_listStory != null) {
      return _listStory!.firstWhere((story) => story.id == id);
    }
    throw Exception('Story not found');
  }

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

  Future<void> addStory({
    required String description,
    required String token,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _apiService.addNewStory(
        _selectedImage!,
        description,
        token,
      );
    } catch (e) {
      _errorMessage = e.toString().split('Exception:').last.trim();
      debugPrint('Error fetching stories: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
