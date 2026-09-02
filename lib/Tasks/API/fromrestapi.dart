import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList>
    with SingleTickerProviderStateMixin {
  List<dynamic> quoteData = [];
  bool isLoading = false;
  int currentIndex = 0;
  bool isDarkMode = false;
  final Set<int> favoriteIndexes = {};
  bool _forward = true;

  // Theme colors
  Color get primaryColor => isDarkMode
      ? const Color(0xFF9C6BFF)
      : Colors.deepPurple;

  List<Color> get bgGradient => isDarkMode
      ? [const Color(0xFF14121F), const Color(0xFF1F1B2E)]
      : [const Color(0xFFF3F0FF), const Color(0xFFE9E4FF)];

  Color get cardColor => isDarkMode ? const Color(0xFF211D33) : Colors.white;

  Color get textColor => isDarkMode ? Colors.white : const Color(0xFF222222);

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.jsonbin.io/v3/b/6a9717aada38895dfe2c3390',
        ),
      );
      if (!mounted) return;
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        setState(() {
          quoteData = decoded['record'];
          currentIndex = 0;
          favoriteIndexes.clear();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (!mounted) return;
      _showSnack('Error: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.redAccent : primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void nextQuote() {
    if (quoteData.isEmpty) return;
    setState(() {
      _forward = true;
      currentIndex = (currentIndex + 1) % quoteData.length;
    });
  }

  void prevQuote() {
    if (quoteData.isEmpty) return;
    setState(() {
      _forward = false;
      currentIndex =
          (currentIndex - 1 + quoteData.length) % quoteData.length;
    });
  }

  void shuffleQuote() {
    if (quoteData.length <= 1) return;
    final rand = Random();
    int newIndex;
    do {
      newIndex = rand.nextInt(quoteData.length);
    } while (newIndex == currentIndex);
    setState(() {
      _forward = true;
      currentIndex = newIndex;
    });
  }

  void toggleFavorite() {
    setState(() {
      if (favoriteIndexes.contains(currentIndex)) {
        favoriteIndexes.remove(currentIndex);
      } else {
        favoriteIndexes.add(currentIndex);
      }
    });
  }

  void copyQuote() {
    if (quoteData.isEmpty) return;
    final quote = quoteData[currentIndex];
    final text = '"${quote['text'] ?? ''}" - ${quote['from'] ?? 'Unknown'}';
    Clipboard.setData(ClipboardData(text: text));
    _showSnack('Quote copied to clipboard 📋');
  }

  void openFavorites() {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final favList = favoriteIndexes.toList()..sort();
        return SizedBox(
          height: MediaQuery.of(ctx).size.height * 0.6,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.star, color: primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      'Favorites (${favList.length})',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: favList.isEmpty
                    ? Center(
                  child: Text(
                    'No favorites yet ⭐',
                    style: TextStyle(color: textColor.withOpacity(0.6)),
                  ),
                )
                    : ListView.builder(
                  itemCount: favList.length,
                  itemBuilder: (ctx, i) {
                    final idx = favList[i];
                    final q = quoteData[idx];
                    return ListTile(
                      leading: Icon(Icons.format_quote,
                          color: primaryColor),
                      title: Text(
                        q['text'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textColor),
                      ),
                      subtitle: Text(
                        '- ${q['from'] ?? 'Unknown'}',
                        style: TextStyle(
                            color: textColor.withOpacity(0.6)),
                      ),
                      onTap: () {
                        setState(() {
                          currentIndex = idx;
                        });
                        Navigator.pop(ctx);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasQuote = quoteData.isNotEmpty;
    final quote = hasQuote ? quoteData[currentIndex] : null;
    final bool isFav = favoriteIndexes.contains(currentIndex);

    return AnimatedTheme(
      data: Theme.of(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: bgGradient,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryColor, primaryColor.withOpacity(0.7)],
                ),
              ),
            ),
            title: const Text(
              'Daily Quotes',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
            ),
            actions: [
              IconButton(
                icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                tooltip: 'Toggle theme',
                onPressed: () => setState(() => isDarkMode = !isDarkMode),
              ),
              if (hasQuote)
                IconButton(
                  icon: const Icon(Icons.star),
                  tooltip: 'Favorites',
                  onPressed: openFavorites,
                ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  if (!hasQuote)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.8, end: 1.0),
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeOutBack,
                              builder: (context, scale, child) => Transform.scale(
                                scale: scale,
                                child: child,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.format_quote,
                                  size: 70,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Get Your Daily Quote',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Press the button to load quotes',
                              style: TextStyle(
                                color: textColor.withOpacity(0.6),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton.icon(
                              onPressed: isLoading ? null : fetchData,
                              icon: isLoading
                                  ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                                  : const Icon(Icons.download),
                              label: Text(
                                isLoading ? 'Loading...' : 'Fetch Quotes',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 6,
                                shadowColor: primaryColor.withOpacity(0.5),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 34,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 350),
                                transitionBuilder: (child, animation) {
                                  final offsetAnim = Tween<Offset>(
                                    begin: Offset(_forward ? 0.15 : -0.15, 0),
                                    end: Offset.zero,
                                  ).animate(animation);
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: offsetAnim,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Container(
                                  key: ValueKey(currentIndex),
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    borderRadius: BorderRadius.circular(28),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor.withOpacity(0.18),
                                        blurRadius: 24,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.format_quote,
                                            size: 46,
                                            color: primaryColor,
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.copy,
                                                    size: 20),
                                                color: textColor
                                                    .withOpacity(0.5),
                                                onPressed: copyQuote,
                                                tooltip: 'Copy',
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  isFav
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  size: 24,
                                                ),
                                                color: isFav
                                                    ? Colors.amber
                                                    : textColor
                                                    .withOpacity(0.5),
                                                onPressed: toggleFavorite,
                                                tooltip: 'Favorite',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '"${quote['text'] ?? ''}"',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Text(
                                        '- ${quote['from'] ?? 'Unknown'}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              quoteData.length > 8 ? 1 : quoteData.length,
                                  (i) => AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 3),
                                width: quoteData.length > 8
                                    ? 60
                                    : (i == currentIndex ? 20 : 8),
                                height: 8,
                                decoration: BoxDecoration(
                                  color: quoteData.length > 8
                                      ? primaryColor
                                      : (i == currentIndex
                                      ? primaryColor
                                      : primaryColor.withOpacity(0.25)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: quoteData.length > 8
                                    ? Center(
                                  child: Text(
                                    '${currentIndex + 1} / ${quoteData.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _circleButton(
                                icon: Icons.arrow_back,
                                onTap: prevQuote,
                              ),
                              const SizedBox(width: 12),
                              _circleButton(
                                icon: Icons.shuffle,
                                onTap: shuffleQuote,
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton.icon(
                                onPressed: nextQuote,
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Next'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 26,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              _circleButton(
                                icon: Icons.refresh,
                                onTap: isLoading ? null : fetchData,
                                loading: isLoading,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback? onTap,
    bool loading = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onTap,
        icon: loading
            ? SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: primaryColor,
          ),
        )
            : Icon(icon, color: primaryColor),
      ),
    );
  }
}