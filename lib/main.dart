import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() {
  runApp(DogWhistleApp());
}

class DogWhistleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Whistle App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WhistleHomePage(),
    );
  }
}

class WhistleHomePage extends StatefulWidget {
  @override
  _WhistleHomePageState createState() => _WhistleHomePageState();
}

class _WhistleHomePageState extends State<WhistleHomePage> {
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
      return 'assets/Dog-whistle-sound-11.200-Hz.wav';
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
        title: Text('Dog Whistle App'),
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
                    trackWidth: 4,
                    progressBarWidth: 10,
                    handlerSize: 10,
                  ),
                  customColors: CustomSliderColors(
                    trackColor: Colors.grey,
                    progressBarColor: Colors.blue,
                    hideShadow: true,
                  ),
                  infoProperties: InfoProperties(
                    mainLabelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleWhistle,
                child: Text(_isPlaying ? 'Start Whistle' : 'Stop Whistle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
