import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class WhistleHomeScreen extends StatefulWidget {
  const WhistleHomeScreen({super.key});

  @override
  State<WhistleHomeScreen> createState() => _WhistleHomeScreenState();
}

class _WhistleHomeScreenState extends State<WhistleHomeScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double _frequency = 1000.0;
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playWhistle() async {
    String assetPath = _getWhistleAssetPath(_frequency);
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource(assetPath));
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseWhistle() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  String _getWhistleAssetPath(double frequency) {
    if (frequency < 10000) {
      return 'assets/tracks/Dog-whistle-sound-11.200-Hz.wav';
    } else if (frequency < 14000) {
      return 'assets/Dog-whistle-sound-12.200-Hz.wav';
    } else if (frequency < 19000) {
      return 'assets/Dog-whistle-sound-16.000-Hz.wav';
    } else {
      return 'assets/Dog-whistle-sound-20.000-Hz.wav';
    }
  }

  void _toggleWhistle() {
    if (_isPlaying) {
      _pauseWhistle();
    } else {
      _playWhistle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dog Whistle App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Frequency: ${_frequency.round()} Hz'),
              SleekCircularSlider(
                initialValue: _frequency,
                min: 100.0,
                max: 25000.0,
                appearance: CircularSliderAppearance(
                  customWidths: CustomSliderWidths(
                    trackWidth: 5,
                    progressBarWidth: 14,
                    handlerSize: 15,
                  ),
                  customColors: CustomSliderColors(
                    trackColor: Colors.grey,
                    progressBarColor: Colors.blue,
                    hideShadow: true,
                  ),
                  infoProperties: InfoProperties(
                    mainLabelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    modifier: (double value) {
                      return '${value.round()} Hz';
                    },
                  ),
                  size: 300,
                  angleRange: 360,
                  startAngle: 90,
                ),
                onChange: (double value) {
                  setState(() {
                    _frequency = value;
                    if (_isPlaying) {
                      _pauseWhistle();
                      _playWhistle();
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleWhistle,
                child: Text(_isPlaying ? 'Stop Whistle' : 'Start Whistle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
