import 'dart:async';

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

    Duration loopDuration = const Duration(milliseconds: 19900);
    Timer.periodic(loopDuration, (timer) async {
      if (!_isPlaying) {
        timer.cancel();
      } else {
        await _audioPlayer.seek(Duration.zero);
        await _audioPlayer.resume();
      }
    });

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
    int index = (frequency / 1000).floor();
    switch (index) {
      case 0:
      case 1:
        return 'tracks/tone_1000Hz.mp3';
      case 2:
        return 'tracks/tone_2000Hz.mp3';
      case 3:
        return 'tracks/tone_3000Hz.mp3';
      case 4:
        return 'tracks/tone_4000Hz.mp3';
      case 5:
        return 'tracks/tone_5000Hz.mp3';
      case 6:
        return 'tracks/tone_6000Hz.mp3';
      case 7:
        return 'tracks/tone_7000Hz.mp3';
      case 8:
        return 'tracks/tone_8000Hz.mp3';
      case 9:
        return 'tracks/tone_9000Hz.mp3';
      case 10:
        return 'tracks/tone_10000Hz.mp3';
      case 11:
        return 'tracks/tone_11000Hz.mp3';
      case 12:
        return 'tracks/tone_12000Hz.mp3';
      case 13:
        return 'tracks/tone_13000Hz.mp3';
      case 14:
        return 'tracks/tone_14000Hz.mp3';
      case 15:
        return 'tracks/tone_15000Hz.mp3';
      case 16:
        return 'tracks/tone_16000Hz.mp3';
      case 17:
        return 'tracks/tone_16000Hz.mp3';
      case 18:
        return 'tracks/tone_16000Hz.mp3';
      case 19:
        return 'tracks/tone_19000Hz.mp3';
      case 21:
        return 'tracks/tone_21000Hz.mp3';
      case 22:
        return 'tracks/tone_22000Hz.mp3';
      case 23:
        return 'tracks/tone_23000Hz.mp3';
      case 24:
        return 'tracks/tone_24000Hz.mp3';
      default:
        return 'tracks/tone_25000Hz.mp3';
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
        title: const Center(
            child: Text(
          'My Whistle',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/image/grassbackground.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Frequency: ${_frequency.round()} Hz',
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
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
                    trackColor: const Color.fromARGB(255, 114, 112, 112),
                    progressBarColor: Colors.blue,
                    hideShadow: true,
                  ),
                  infoProperties: InfoProperties(
                    mainLabelStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    modifier: (double value) {
                      return '${value.round()} Hz';
                    },
                  ),
                  size: 270,
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _toggleWhistle,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: _isPlaying ? Colors.red : Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                ),
                child: Text(
                  _isPlaying ? 'Stop Whistle' : 'Start Whistle',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
