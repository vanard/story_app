import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/overlay_provider.dart';
import 'package:story_app/providers/stories_provider.dart';

class ImagePickerSheet extends StatefulWidget {
  const ImagePickerSheet({super.key});

  @override
  State<ImagePickerSheet> createState() => _ImagePickerSheetState();
}

class _ImagePickerSheetState extends State<ImagePickerSheet> {
  final _imagePicker = ImagePicker();

  void _pickImage(ImageSource source) {
    debugPrint('Pick image from gallery');
    final provider = context.read<StoriesProvider>();
    _imagePicker
        .pickImage(source: source)
        .then((image) {
          if (image != null) {
            provider.setSelectedImage(File(image.path));
            provider.getImageFileSize(image.path);
          }
        })
        .catchError((error) {
          debugPrint('Error picking image: $error');
          if (!mounted) return;
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error)));
        });
    context.read<OverlayProvider>().clearOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Iconsax.gallery),
            title: Text(AppLocalizations.of(context)!.gallery),
            onTap: () {
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Iconsax.camera),
            title: Text(AppLocalizations.of(context)!.camera),
            onTap: () {
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
    // return SafeArea(
    //   child: Wrap(
    //     children: [
    //       ListTile(
    //         leading: const Icon(Icons.camera_alt),
    //         title: const Text("Camera"),
    //         onTap: onCameraTap,
    //       ),
    //       ListTile(
    //         leading: const Icon(Icons.photo),
    //         title: const Text("Gallery"),
    //         onTap: onGalleryTap,
    //       ),
    //     ],
    //   ),
    // );
  }
}
