import 'package:flutter/material.dart';

 class PremiumGrid extends StatefulWidget {
  const PremiumGrid({super.key});

  @override
  State<PremiumGrid> createState() => _PremiumGridState();
}

class _PremiumGridState extends State<PremiumGrid> {
  bool isGrid = true;

  final List<Map<String, String>> photos = List.generate(
    12,
        (index) => {
      'url': 'https://picsum.photos/400?image=${237 + index}',
      'title': 'Photo ${index + 1}',
      'subtitle': 'Captured on location ${index + 1}',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text(
                'Gallery',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                tooltip: isGrid ? 'Switch to list' : 'Switch to grid',
                icon: Icon(
                  isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded,
                  color: Colors.white,
                ),
                onPressed: () => setState(() => isGrid = !isGrid),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(14),
            sliver: isGrid ? _buildGridSliver() : _buildListSliver(),
          ),
        ],
      ),
    );
  }

  Widget _buildGridSliver() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.8,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => _PhotoCard(
          url: photos[index]['url']!,
          title: photos[index]['title']!,
        ),
        childCount: photos.length,
      ),
    );
  }

  Widget _buildListSliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _PhotoListTile(
            url: photos[index]['url']!,
            title: photos[index]['title']!,
            subtitle: photos[index]['subtitle']!,
          ),
        ),
        childCount: photos.length,
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final String url;
  final String title;

  const _PhotoCard({required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: url,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.55),
                    ],
                  ),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoListTile extends StatelessWidget {
  final String url;
  final String title;
  final String subtitle;

  const _PhotoListTile({
    required this.url,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Hero(
              tag: url,
              child: Image.network(
                url,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}