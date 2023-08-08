import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DrumPage extends StatefulWidget {
  const DrumPage({super.key});

  @override
  State<DrumPage> createState() => _DrumPageState();
}

class _DrumPageState extends State<DrumPage> {
  final oynatici = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          buildRow('bip', 'bongo', Colors.blue, Colors.red),
          buildRow('clap1', 'clap2', Colors.purple, Colors.yellowAccent),
          buildRow('clap3', 'crash', Colors.white, Colors.green),
          buildRow('how', 'oobah', Colors.orange, Colors.purpleAccent),
        ],
      ),
    );
  }

  Expanded buildRow(String $SounddName1, String $SounddName2, color1, color2) {
    return Expanded(
      child: Row(
        children: [
          buildDrumPadButton($SounddName1, color1),
          buildDrumPadButton($SounddName2, color2),
        ],
      ),
    );
  }

  Widget buildDrumPadButton(String SoundName, Color color) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          oynatici.play(
            AssetSource('$SoundName.wav'),
          );
        },
        child: Container(
          color: color,
        ),
      ),
    );
  }
}
