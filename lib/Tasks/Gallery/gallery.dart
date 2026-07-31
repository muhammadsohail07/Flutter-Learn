import 'package:flutter/material.dart';

class GalleryUI extends StatelessWidget {
  const GalleryUI({super.key});

  final List<String> imageUrls = const [
    'https://picsum.photos/250?image=237',
    'https://picsum.photos/250?image=238',
    'https://picsum.photos/250?image=239',
    'https://picsum.photos/250?image=240',
    'https://picsum.photos/250?image=241',
    'https://picsum.photos/250?image=242',
    'https://picsum.photos/250?image=243',
    'https://picsum.photos/250?image=244',
    'https://picsum.photos/250?image=245',
    'https://picsum.photos/250?image=246',
    'https://picsum.photos/250?image=247',
    'https://picsum.photos/250?image=248',
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text('Stack')),
        body: GridView.builder(
          padding: const EdgeInsets.all(10),

          scrollDirection: Axis.vertical,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.0,
          ),

          itemCount: imageUrls.length,

          shrinkWrap: false,

          physics: const BouncingScrollPhysics(),

          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,

                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },

                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, color: Colors.grey);
                },
              ),
            );
          },
        ),
    );
  }
}
