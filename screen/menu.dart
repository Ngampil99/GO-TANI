import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_tani/screen/go_cost/fixedcost.dart';
import 'package:go_tani/screen/go_sip.dart';
import 'package:go_tani/screen/login.dart';
import 'package:go_tani/screen/reward.dart';
import 'package:go_tani/services/lagu.dart';
import 'package:go_tani/services/user_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:go_tani/services/notification_controller.dart';
import 'go_process/goprocess.dart';
import 'package:go_tani/main.dart';

class MainMenu extends StatelessWidget {
  void _clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('mulai2');
    await prefs.remove('cost');
    await prefs.remove('pendapatan');
    await prefs.remove('revenue');
    await prefs.remove('bcDecimal');
    await prefs.remove('rcDecimal');
    await prefs.remove('bcRatio');
    await prefs.remove('rcRatio');
    await prefs.remove('benih');
    await prefs.remove('infobenih');
    await prefs.remove('varietas');
    await prefs.remove('infovar');
    await prefs.remove('isButton1Pressed');
    await prefs.remove('isButton2Pressed');
    await prefs.remove('isButton3Pressed');
    await prefs.remove('isButton4Pressed');
    await prefs.remove('isButton5Pressed');
    await prefs.remove('isButton6Pressed');
  }

  void checkNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      // Izin notifikasi belum diberikan, maka tampilkan permintaan izin.
      await NotificationController.displayNotificationRationale();
    }
  }

  ButtonStyle kButtonStyle(BuildContext context, double width, double height) {
    double fontSize =
        height * 0.35; // Adjust the percentage as needed for font size
    return ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 210, 149, 81),
      foregroundColor: Colors.black,
      side: const BorderSide(color: Color.fromARGB(255, 77, 39, 9), width: 2),
      minimumSize: Size(width, height),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(35.0), // Adjust the radius as needed
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: 20), // Adjust padding as needed
      textStyle: GoogleFonts.getFont('Poppins',
          fontSize: fontSize, fontWeight: FontWeight.w600), // Set font size
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonWidth = screenWidth * 0.25; // Adjust the percentage as needed
    double buttonHeight = screenHeight * 0.20;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          foregroundColor: Colors.black,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                final klik = AudioPlayer();
                klik.setVolume(1.0);
                klik.play(
                  AssetSource('click.mp3'),
                );
                _clearSharedPreferences();
              },
            ),
            IconButton(
                onPressed: () {
                  AudioManager.stopSong();
                  // final backsong = AudioPlayer(playerId: 'lagu');
                  // backsong.stop();
                  final klik = AudioPlayer();
                  klik.setVolume(1.0);
                  klik.play(
                    AssetSource('click.mp3'),
                  );
                  logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Login()),
                            (route) => false)
                      });
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image13,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                top: buttonHeight,
                left: 0,
                right: 0,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            final klik = AudioPlayer();
                            klik.setVolume(1.0);
                            klik.play(
                              AssetSource('click.mp3'),
                            );
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        GOProcess(),
                              ),
                            );
                          },
                          style:
                              kButtonStyle(context, buttonWidth, buttonHeight),
                          child: const Text('Go-Process')),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          final klik = AudioPlayer();
                          klik.setVolume(1.0);
                          klik.play(
                            AssetSource('click.mp3'),
                          );
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      FixedCost(),
                            ),
                          );
                        },
                        style: kButtonStyle(context, buttonWidth, buttonHeight),
                        child: const Text('Go-Cost'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          final klik = AudioPlayer();
                          klik.setVolume(1.0);
                          klik.play(
                            AssetSource('click.mp3'),
                          );
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      GoReward(),
                            ),
                          );
                        },
                        style: kButtonStyle(context, buttonWidth, buttonHeight),
                        child: const Text('Go-Reward'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            final klik = AudioPlayer();
                            klik.setVolume(1.0);
                            klik.play(
                              AssetSource('click.mp3'),
                            );
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        GoSip(),
                              ),
                            );
                          },
                          style:
                              kButtonStyle(context, buttonWidth*2/3, buttonHeight*2/3),
                          child: const Text('Go-Ask')),
                ]),
                ])),
            Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: buttonWidth, // Lebar Container
                  height: buttonWidth, // Tinggi Container
                  color: Colors.transparent, // Warna Container (opsional)
                  child: Image.asset(
                    'assets/gotan sedekap.png', // Lokasi gambar aset Anda
                    fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                  ),
                )),
            Positioned(
                right: buttonWidth - (buttonWidth/4),
                bottom: 0,
                child: Container(
                  width: buttonWidth*11/10, // Lebar Container
                height: buttonWidth*11/10, // Tinggi Container
                  color: Colors.transparent, // Warna Container (opsional)
                  child: Image.asset(
                    'assets/1. gotan-beranda.png', // Lokasi gambar aset Anda
                    fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
