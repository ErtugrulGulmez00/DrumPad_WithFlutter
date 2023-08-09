import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DrumPage extends StatefulWidget {
  const DrumPage({super.key});

  @override
  State<DrumPage> createState() => _DrumPageState();
}

class _DrumPageState extends State<DrumPage> {
  final oynatici = AudioPlayer();
  double _xOffset = 0.0;

  List<Map<String, dynamic>> rowList = [
    {
      'text1': 'bip',
      'text2': 'bongo',
      'color1': Colors.blue,
      'color2': Colors.red,
    },
    {
      'text1': 'clap1',
      'text2': 'clap2',
      'color1': Colors.purple,
      'color2': Colors.yellowAccent,
    },
    {
      'text1': 'clap3',
      'text2': 'crash',
      'color1': Colors.white,
      'color2': Colors.green,
    },
    {'text1': 'how',
      'text2': 'oobah',
      'color1': Colors.orange,
      'color2': Colors.grey,
    },
    // { //sonradan eklenen ses ve renk butonu
    //   'text1': 'ridebel',
    //   'text2': 'woo',
    //   'color1': Colors.white10,
    //   'color2': Colors.redAccent,
    // }

    // ... Diğer sesler ve renkler buraya eklenebilir.
  ];


  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _xOffset = 20.0;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _xOffset = 0.0;
        });
        _startAnimation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            transform: Matrix4.translationValues(_xOffset, 0, 0),



            child: Text(
              'DRUM PAD <3',
              style: GoogleFonts.eagleLake(
                  textStyle: TextStyle(fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    letterSpacing: 2,
                    decoration: TextDecoration.none,)),
            ),
          ),
          SizedBox(height: 25),
          ...rowList.map((row) {
            return buildRow(row['text1'], row['text2'], row['color1'], row['color2']);
          }).toList(),
        ],
      ),
    );
  }

  Widget buildRow(String SounddName1, String SounddName2, Color color1, Color color2) {
    return Expanded(
      child: Row(
        children: [
          buildDrumPadButton(SounddName1, color1),
          SizedBox(width: 8), // Butonlar arasında boşluk
          buildDrumPadButton(SounddName2, color2),
        ],
      ),
    );
  }
   playSound(String SoundName) async {
    await oynatici.play(
      AssetSource('$SoundName.wav'),
    );
  }

  Widget buildDrumPadButton(String SoundName, Color color) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            color = Colors.black; // Siyah renk atanıyor
          });
          oynatici.play(
            playSound(SoundName),
          );
        },
        onTapUp: (_) {
          setState(() {
            color = color; // İlk rengine dönüş yapılıyor
          });
        },
        onTapCancel: () {
          setState(() {
            color = color; // İptal edilen durumda da rengi eski haline getiriyoruz
          });
        },
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(50), // Oval köşeler
            color: color,
          ),
        ),
      ),
    );
  }}