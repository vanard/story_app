import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/util/exception_helper.dart';

class ApiService {
  static const _baseUrl = 'https://story-api.dicoding.dev/v1';

  late final http.Client _client;

  ApiService({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<Map<String, dynamic>> registerUser(
    String name,
    String email,
    String pass,
  ) async {
    final user = {'name': name, 'email': email, 'password': pass};

    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/register'),
        // headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(user),
      );
      debugPrint(response.body);
      debugPrint('status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw handleError(response.statusCode);
      }
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String pass) async {
    final user = {'email': email, 'password': pass};

    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/login'),
        // headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(user),
      );
      debugPrint(response.body);
      debugPrint('status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw handleError(response.statusCode);
      }
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<Map<String, dynamic>> addNewStory(File image, String token) async {
    final req = http.MultipartRequest('POST', Uri.parse('$_baseUrl/login'));
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data",
    };
    // req.headers['Authorization'] = 'Bearer $token';
    req.headers.addAll(headers);
    req.files.add(
      await http.MultipartFile.fromPath(
        'stories',
        image.path,
        filename: image.path.split('/').last,
      ),
    );

    try {
      final streamedResponse = await req.send();
      final response = await http.Response.fromStream(streamedResponse);
      debugPrint(response.body);
      debugPrint('status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw handleError(response.statusCode);
      }
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<Map<String, dynamic>> getStories(
    int page,
    int size,
    String token,
  ) async {
    // final uri = Uri.https(_baseUrl, '/stories', {'page': page, 'size': size});

    try {
      final response = await _client.get(
        // uri,
        Uri.parse('$_baseUrl/stories'),
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );
      debugPrint(response.body);
      debugPrint('status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw handleError(response.statusCode);
      }
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<Map<String, dynamic>> getStoryById(String id, String token) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/stories/$id'),
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );
      debugPrint(response.body);
      debugPrint('status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw handleError(response.statusCode);
      }
    } catch (e) {
      throw handleException(e);
    }
  }

  void dispose() {
    _client.close();
  }
}
