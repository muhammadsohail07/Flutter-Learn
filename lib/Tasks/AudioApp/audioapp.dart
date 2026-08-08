import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioApp extends StatefulWidget {
  const AudioApp({super.key});

  @override
  State<AudioApp> createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  final AudioPlayer audioPlayer = AudioPlayer(); // Audio player instance.

  @override
  void dispose() {
    audioPlayer.dispose(); // Release audio player resources.
    super.dispose();
  }

  // Plays an audio file.
  void playAudio() async {
    try {
      if (kIsWeb) {
        // Web needs the actual served asset URL, not the raw asset path.
        await audioPlayer.play(
          UrlSource('assets/Assets/Audio/Kalyani.mp3'),
        );
      } else {
        await audioPlayer.play(
          AssetSource('Assets/Audio/Kalyani.mp3'),
        );
      }
    } catch (e) {
      debugPrint('Audio play error: $e');
    }
  }

  // Stops the audio playback.
  void stopAudio() async {
    await audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Player Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: playAudio, child: const Text('Play Audio')),
            ElevatedButton(
                onPressed: stopAudio, child: const Text('Stop Audio')),
          ],
        ),
      ),
    );
  }
}