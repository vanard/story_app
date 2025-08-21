import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/providers/stories_provider.dart';
import 'package:story_app/routes/router_helper.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  late final _provider = Provider.of<StoriesProvider>(context, listen: false);
  final _descriptionController = TextEditingController();

  void _openImagePicker() {
    debugPrint('Open image picker');
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Iconsax.gallery),
              title: Text(AppLocalizations.of(context)!.gallery),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.camera),
              title: Text(AppLocalizations.of(context)!.camera),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage(ImageSource source) {
    debugPrint('Pick image from gallery');
    _imagePicker
        .pickImage(source: source)
        .then((image) {
          if (image != null) {
            _provider.setSelectedImage(File(image.path));
            _provider.getImageFileSize(image.path);
          }
        })
        .catchError((error) {
          debugPrint('Error picking image: $error');
          if (!mounted) return;
          _showMessage('Error picking image: $error');
        });
  }

  void _submitStory() async {
    debugPrint('Submit story');
    final description = _descriptionController.text.trim();
    if (description.isEmpty) {
      _showMessage(AppLocalizations.of(context)!.descriptionRequired);
      return;
    }

    if (_provider.selectedImage == null) {
      _showMessage(AppLocalizations.of(context)!.imageRequired);
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.loginUser?.token ?? '';

    debugPrint('current token: $token');

    try {
      await _provider.addStory(description: description, token: token);
      _descriptionController.clear();
      _provider.setSelectedImage(null);
      _provider.fetchStories(token: token);
      if (!mounted) return;
      _showMessage(AppLocalizations.of(context)!.storyAdded);
      context.navigateToTab(0);
    } catch (e) {
      debugPrint('Error submitting story: $e');
      _showMessage('Error submitting story: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StoriesProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.addStory)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (provider.selectedImage == null)
              IconButton(
                icon: Icon(Iconsax.add),
                iconSize: 200,
                onPressed: _openImagePicker,
              )
            else
              GestureDetector(
                onTap: _openImagePicker,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.file(
                    _provider.selectedImage ?? File(''),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            const SizedBox(height: 30),
            TextField(
              controller: _descriptionController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: appLocalizations.description,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              style: TextStyle().copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                onPressed: _submitStory,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: provider.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    : Text(appLocalizations.upload),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
