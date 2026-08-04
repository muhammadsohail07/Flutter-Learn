import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedNetworkimages extends StatelessWidget {
  const CachedNetworkimages ({super.key});

  static const String _imageUrl = "https://picsum.photos/350/150";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cached Network Images"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: _imageUrl,
              width: 350,
              height: 150,
              fit: BoxFit.cover,

              // Fade-in animation once image loads
              fadeInDuration: const Duration(milliseconds: 400),
              fadeInCurve: Curves.easeIn,

              // Loading state with progress + text
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return SizedBox(
                  width: 350,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: downloadProgress.progress,
                        strokeWidth: 3,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        downloadProgress.progress != null
                            ? "${(downloadProgress.progress! * 100).toStringAsFixed(0)}%"
                            : "Loading...",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },

              // Error state with retry option
              errorWidget: (context, url, error) {
                return SizedBox(
                  width: 350,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.broken_image_outlined,
                          size: 40, color: Colors.redAccent),
                      const SizedBox(height: 8),
                      const Text(
                        "Image load nahi hui",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () {
                          // Force rebuild to retry
                          (context as Element).markNeedsBuild();
                        },
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}