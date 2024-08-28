import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FullScreenImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('image_preview'.tr()),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          panEnabled: true, // Allows panning (moving the image)
          minScale: 0.5,
          maxScale: 3.0, // Maximum zoom level
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 200, color: Colors.white);
            },
          ),
        ),
      ),
    );
  }
}


/**
            CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain, // Maintains the aspect ratio of the image
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 200, color: Colors.white),
          ),
 */