import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/services/lagu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'menu.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    startProgress();
  }

  void startProgress() {
    Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      setState(() {
        _progressValue += 0.01;
        if (_progressValue >= 1.0) {
          timer.cancel();
          navigateToNextScreen();
          // final backsong = AudioPlayer(playerId: 'lagu');
          // backsong.setReleaseMode(ReleaseMode.loop);
          // backsong.setVolume(0.4);
          // backsong.play(
          //   AssetSource('farm-165253.mp3'),
          // );
          AudioManager.playSong('farm-165253.mp3');
        }
      });
    });
  }

  void navigateToNextScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainMenu()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 15, 80, 135),
          image: DecorationImage(
            image: image12,
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            Container(
              height: screenHeight / 3.5,
              width: screenHeight / 3.5,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.black, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: image15, // Gambar yang ingin Anda tampilkan
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: screenHeight / 5,
              width: screenHeight,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 210, 149, 81),
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Text(
                    "Go-Tani merupakan perangkat gamifikasi dan terintegrasi sensor yang membuat kegiatan bertani jadi lebih mudah dan menyenangkan.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: screenHeight / 20,
              width: screenHeight,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _progressValue,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 14, 136, 10),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]));
  }
}
