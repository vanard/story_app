import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/providers/overlay_provider.dart';
import 'package:story_app/providers/stories_provider.dart';
import 'package:story_app/routes/page_configuration.dart';
import 'package:story_app/routes/router_helper.dart';
import 'package:story_app/util/constants.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  late final StoriesProvider _provider;
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = context.read<StoriesProvider>();
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

    final authProvider = context.read<AuthProvider>();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (provider.selectedImage == null)
              IconButton(
                icon: Icon(Iconsax.add),
                iconSize: 180,
                onPressed: () {
                  context.read<OverlayProvider>().showOverlay(
                    OverlayType.bottomSheet,
                    chooseImagePicker,
                  );
                },
              )
            else
              GestureDetector(
                onTap: () {
                  context.read<OverlayProvider>().showOverlay(
                    OverlayType.bottomSheet,
                    chooseImagePicker,
                  );
                },
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
