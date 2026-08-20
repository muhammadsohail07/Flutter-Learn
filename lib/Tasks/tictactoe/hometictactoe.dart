import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '', growable: false);
  String currentPlayer = 'X';
  String? winner;
  List<int> winningLine = [];

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

  @override
  Widget build(BuildContext context) {
    final statusText = winner == 'Draw'
        ? "It's a Draw"
        : winner != null
        ? '$winner Wins'
        : "$currentPlayer's Turn";

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
            Text(
              statusText,
              style: TextStyle(
                color: winner != null && winner != 'Draw'
                    ? _markColor(winner!)
                    : Colors.white70,
                fontSize: 22,
                fontWeight: FontWeight.w500,
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
                        final isWinCell = winningLine.contains(index);
                        return GestureDetector(
                          onTap: () => _markCell(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: isWinCell ? gold.withOpacity(0.15) : card,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isWinCell ? gold : Colors.white10,
                                width: isWinCell ? 1.5 : 1,
                              ),
                            ),
                            child: Center(
                              child: AnimatedScale(
                                scale: board[index] == '' ? 0 : 1,
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.easeOutBack,
                                child: Text(
                                  board[index],
                                  style: TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.w700,
                                    color: _markColor(board[index] == '' ? 'X' : board[index]),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: TextButton(
                onPressed: _resetGame,
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
          ],
        ),
      ),
    );
  }
}