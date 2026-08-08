import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioApp extends StatefulWidget {
  const AudioApp({super.key});

  @override
  State<AudioApp> createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isLoading = false;
  double volume = 1.0;

  static const Color primaryColor = Color(0xFF6A11CB);

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void togglePlay() async {
    setState(() => isLoading = true);
    try {
      if (isPlaying) {
        await audioPlayer.pause();
      } else {
        if (kIsWeb) {
          await audioPlayer.play(UrlSource('assets/Assets/Audio/Kalyani.mp3'));
        } else {
          await audioPlayer.play(AssetSource('Assets/Audio/Kalyani.mp3'));
        }
        await audioPlayer.setVolume(volume);
      }
    } catch (e) {
      debugPrint('Audio play error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to play audio')),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void stopAudio() async {
    await audioPlayer.stop();
    setState(() => isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Now Playing'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.08),
                  border: Border.all(
                    color: primaryColor.withOpacity(0.25),
                    width: 3,
                  ),
                ),
                child: Icon(
                  Icons.music_note_rounded,
                  size: 70,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Kalyani',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isPlaying ? 'Playing...' : 'Paused',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _controlButton(
                    icon: Icons.stop_rounded,
                    onTap: stopAudio,
                    size: 54,
                  ),
                  const SizedBox(width: 20),
                  _controlButton(
                    icon: isLoading
                        ? null
                        : (isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded),
                    onTap: isLoading ? null : togglePlay,
                    size: 74,
                    primary: true,
                    loading: isLoading,
                  ),
                  const SizedBox(width: 20),
                  _controlButton(
                    icon: Icons.replay_rounded,
                    onTap: () async {
                      await audioPlayer.seek(Duration.zero);
                    },
                    size: 54,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Icon(
                    volume == 0
                        ? Icons.volume_off_rounded
                        : Icons.volume_up_rounded,
                    color: primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: primaryColor,
                        inactiveTrackColor: primaryColor.withOpacity(0.15),
                        thumbColor: primaryColor,
                        overlayColor: primaryColor.withOpacity(0.15),
                        trackHeight: 3,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 7,
                        ),
                      ),
                      child: Slider(
                        value: volume,
                        min: 0,
                        max: 1,
                        onChanged: (value) async {
                          setState(() => volume = value);
                          await audioPlayer.setVolume(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _controlButton({
    IconData? icon,
    VoidCallback? onTap,
    required double size,
    bool primary = false,
    bool loading = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primary ? primaryColor : primaryColor.withOpacity(0.08),
          boxShadow: primary
              ? [
            BoxShadow(
              color: primaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: loading
            ? Padding(
          padding: const EdgeInsets.all(18),
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: primary ? Colors.white : primaryColor,
          ),
        )
            : Icon(
          icon,
          size: size * 0.5,
          color: primary ? Colors.white : primaryColor,
        ),
      ),
    );
  }
}