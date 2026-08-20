import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen>
    with SingleTickerProviderStateMixin {
  List<String> board = List.filled(9, '', growable: false);
  String currentPlayer = 'X';
  String? winner; // 'X', 'O', or 'Draw'
  List<int> winningLine = [];

  late final AnimationController _pulseController;

  static const List<List<int>> _winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6],
  ];

  static const Color bg = Color(0xFF0F1115);
  static const Color card = Color(0xFF1A1D24);
  static const Color accentX = Color(0xFF6C8CFF);
  static const Color accentO = Color(0xFFFF6C8C);
  static const Color gold = Color(0xFFD4AF37);

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _markCell(int index) {
    if (board[index] != '' || winner != null) return;
    setState(() {
      board[index] = currentPlayer;
      final result = _checkWinner();
      if (result != null) {
        winner = result;
      } else if (!board.contains('')) {
        winner = 'Draw';
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  String? _checkWinner() {
    for (final p in _winPatterns) {
      if (board[p[0]] != '' && board[p[0]] == board[p[1]] && board[p[1]] == board[p[2]]) {
        winningLine = p;
        return board[p[0]];
      }
    }
    return null;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '', growable: false);
      currentPlayer = 'X';
      winner = null;
      winningLine = [];
    });
  }

  Color _markColor(String m) => m == 'X' ? accentX : accentO;

  // Loser is the mark that is NOT the winner, once someone has won.
  String? get _loserMark {
    if (winner == null || winner == 'Draw') return null;
    return winner == 'X' ? 'O' : 'X';
  }

  @override
  Widget build(BuildContext context) {
    final statusText = winner == 'Draw'
        ? "It's a Draw"
        : winner != null
        ? '$winner Wins 🏆'
        : "$currentPlayer's Turn";

    final statusColor = winner != null && winner != 'Draw'
        ? _markColor(winner!)
        : Colors.white70;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'TIC TAC TOE',
              style: TextStyle(
                color: gold,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 6,
              ),
            ),
            const SizedBox(height: 40),

            // Animated status: winner / loser / turn indicator
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => ScaleTransition(
                scale: anim,
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: Column(
                key: ValueKey(statusText),
                children: [
                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (_loserMark != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      '$_loserMark Loses',
                      style: TextStyle(
                        color: _markColor(_loserMark!).withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const Spacer(),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420, maxHeight: 420),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: board.length,
                      itemBuilder: (context, index) {
                        final mark = board[index];
                        final isWinCell = winningLine.contains(index);
                        final isLoserCell =
                            winner != null && winner != 'Draw' && mark == _loserMark;

                        return GestureDetector(
                          onTap: () => _markCell(index),
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              final pulse = isWinCell
                                  ? 0.15 + (_pulseController.value * 0.15)
                                  : 0.0;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                                decoration: BoxDecoration(
                                  color: isWinCell
                                      ? gold.withOpacity(0.15 + pulse)
                                      : card,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isWinCell ? gold : Colors.white10,
                                    width: isWinCell ? 1.5 : 1,
                                  ),
                                  boxShadow: isWinCell
                                      ? [
                                    BoxShadow(
                                      color: gold.withOpacity(0.25 + pulse),
                                      blurRadius: 16,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                      : [],
                                ),
                                child: child,
                              );
                            },
                            child: Center(
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(
                                  begin: 0,
                                  end: mark == '' ? 0 : 1,
                                ),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutBack,
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: Transform.rotate(
                                      angle: (1 - value) * 0.6,
                                      child: child,
                                    ),
                                  );
                                },
                                child: AnimatedOpacity(
                                  opacity: isLoserCell ? 0.35 : 1.0,
                                  duration: const Duration(milliseconds: 400),
                                  child: Text(
                                    mark,
                                    style: TextStyle(
                                      fontSize: 44,
                                      fontWeight: FontWeight.w700,
                                      color: _markColor(mark == '' ? 'X' : mark),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),

            AnimatedOpacity(
              opacity: winner != null ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: TextButton(
                  onPressed: winner != null ? _resetGame : null,
                  style: TextButton.styleFrom(
                    backgroundColor: card,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: gold, width: 1),
                    ),
                  ),
                  child: const Text(
                    'RESTART',
                    style: TextStyle(color: gold, letterSpacing: 2, fontWeight: FontWeight.w600),
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