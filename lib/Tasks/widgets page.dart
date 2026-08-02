import 'package:flutter/material.dart';




class PremiumHomePage extends StatelessWidget {
  const PremiumHomePage({super.key});

  static const List<Map<String, dynamic>> categories = [
    {'icon': Icons.local_fire_department, 'label': 'Trending'},
    {'icon': Icons.star, 'label': 'Top Rated'},
    {'icon': Icons.new_releases, 'label': 'New'},
    {'icon': Icons.favorite, 'label': 'Loved'},
    {'icon': Icons.local_offer, 'label': 'Deals'},
    {'icon': Icons.category, 'label': 'All'},
  ];

  static const List<Map<String, String>> items = [
    {'title': 'Golden Reserve', 'subtitle': 'Premium blend • 250g'},
    {'title': 'Velvet Noir', 'subtitle': 'Signature edition • 100g'},
    {'title': 'Royal Amber', 'subtitle': 'Limited stock • 500g'},
    {'title': 'Silk Bloom', 'subtitle': 'Handpicked • 150g'},
    {'title': 'Obsidian Crest', 'subtitle': 'Best seller • 300g'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PremiumHomePage"),),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Good Evening',
                          style: TextStyle(color: Colors.white54, fontSize: 13),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Sohail',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFD66B), Color(0xFFFF8A65)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.notifications_none, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6C4AB6), Color(0xFF2E2E52)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Premium Collection\nUp to 40% Off',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Shop Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C1C2E),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Icon(cat['icon'] as IconData,
                              color: const Color(0xFFFFD66B), size: 22),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          cat['label'] as String,
                          style: const TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  'Popular Picks',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C2E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.primaries[index % Colors.primaries.length]
                                        .withOpacity(0.6),
                                    const Color(0xFF1C1C2E),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: const Icon(Icons.local_cafe,
                                  color: Colors.white70, size: 34),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Item ${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '\$24.99',
                                      style: TextStyle(
                                        color: Color(0xFFFFD66B),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const Icon(Icons.favorite_border,
                                        color: Colors.white38, size: 16),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 4,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Text(
                  'Recommended',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final item = items[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C2E),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.primaries[
                                  (index + 3) % Colors.primaries.length]
                                      .withOpacity(0.7),
                                  const Color(0xFF1C1C2E),
                                ],
                              ),
                            ),
                            child: const Icon(Icons.emoji_food_beverage,
                                color: Colors.white70),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['subtitle']!,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              color: Colors.white38, size: 14),
                        ],
                      ),
                    );
                  },
                  childCount: items.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}