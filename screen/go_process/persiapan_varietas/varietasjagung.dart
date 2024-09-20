// ignore_for_file: unnecessary_import, unused_local_variable

import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/screen/go_process/persiapan_varietas/infovar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_tani/screen/go_process/persiapan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VarietasJagung extends StatefulWidget {
  @override
  _VarietasJagungState createState() => _VarietasJagungState();
}

class _VarietasJagungState extends State<VarietasJagung> {
  double opasiti1 = 1;
  double opasiti2 = 1;
  double opasiti3 = 1;
  double opasiti4 = 1;
  double latestPhValue = 0;
  double latestKelembapanValue = 0;
  double latestKetinggianValue = 0;
  double latestSuhuValue = 0;

  @override
  void initState() {
    super.initState();
    getDataSensor();
  }

  Future<void> aturOpasiti() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mulai2 = prefs.getString('mulai2') ?? '';
    String tanam = (mulai2.isEmpty) ? 'a' : 'b';
    if (tanam == 'b') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String benih = prefs.getString('benih') ?? '';
      if (benih == 'padi') {
        if ((latestPhValue >= 4.5 && latestPhValue <= 5.5) ||
            (latestPhValue >= 7.0 && latestPhValue <= 8.0)) {
          setState(() {
            opasiti1 = 1;
          });
        } else {
          setState(() {
            opasiti1 = 0.5;
          });
        }
        if (latestKelembapanValue >= 30.0 && latestKelembapanValue <= 33.0) {
          setState(() {
            opasiti2 = 1;
          });
        } else {
          setState(() {
            opasiti2 = 0.5;
          });
        }
        if (latestKetinggianValue >= 30.0 && latestKetinggianValue <= 33.0) {
          setState(() {
            opasiti3 = 1;
          });
        } else {
          setState(() {
            opasiti3 = 0.5;
          });
        }
        if ((latestSuhuValue >= 22.0 && latestSuhuValue <= 24.0) ||
            (latestSuhuValue >= 29.0 && latestSuhuValue <= 32.0)) {
          setState(() {
            opasiti4 = 1;
          });
        } else {
          setState(() {
            opasiti4 = 0.5;
          });
        }
      } else if (benih == 'jagung') {
        //If else untuk benih jagung
        if ((latestPhValue >= 5.5 && latestPhValue <= 5.8) ||
            (latestPhValue >= 7.8 && latestPhValue <= 8.2)) {
          setState(() {
            opasiti1 = 1;
          });
        } else {
          setState(() {
            opasiti1 = 0.5;
          });
        }
        if (latestKelembapanValue >= 36.0 && latestKelembapanValue <= 42.0) {
          setState(() {
            opasiti2 = 1;
          });
        } else {
          setState(() {
            opasiti2 = 0.5;
          });
        }
        if (latestKetinggianValue >= 30.0 && latestKetinggianValue <= 33.0) {
          setState(() {
            opasiti3 = 1;
          });
        } else {
          setState(() {
            opasiti3 = 0.5;
          });
        }
        if (latestSuhuValue >= 26.0 && latestSuhuValue <= 30.0) {
          setState(() {
            opasiti4 = 1;
          });
        } else {
          setState(() {
            opasiti4 = 0.5;
          });
        }
      } else if (benih == 'kacang tanah') {
        if ((latestPhValue >= 5.0 && latestPhValue <= 6.0) ||
            (latestPhValue >= 7.0 && latestPhValue <= 7.5)) {
          setState(() {
            opasiti1 = 1;
          });
        } else {
          setState(() {
            opasiti1 = 0.5;
          });
        }
        if (latestKelembapanValue > 80.0 || latestKelembapanValue < 80.0) {
          setState(() {
            opasiti2 = 1;
          });
        } else {
          setState(() {
            opasiti2 = 0.5;
          });
        }
        if (latestKetinggianValue >= 30.0 && latestKetinggianValue <= 33.0) {
          setState(() {
            opasiti3 = 1;
          });
        } else {
          setState(() {
            opasiti3 = 0.5;
          });
        }
        if ((latestSuhuValue >= 20.0 && latestSuhuValue <= 25.0) ||
            (latestSuhuValue >= 27.0 && latestSuhuValue <= 30.0)) {
          setState(() {
            opasiti4 = 1;
          });
        } else {
          setState(() {
            opasiti4 = 0.5;
          });
        }
      } else if (benih == 'kedelai') {
        if ((latestPhValue >= 5.0 && latestPhValue <= 5.5) ||
            (latestPhValue >= 7.5 && latestPhValue <= 7.8)) {
          setState(() {
            opasiti1 = 1;
          });
        } else {
          setState(() {
            opasiti1 = 0.5;
          });
        }
        if (latestKelembapanValue > 80.0 && latestKelembapanValue < 50.0) {
          setState(() {
            opasiti2 = 1;
          });
        } else {
          setState(() {
            opasiti2 = 0.5;
          });
        }
        if (latestKetinggianValue >= 30.0 && latestKetinggianValue <= 33.0) {
          setState(() {
            opasiti3 = 1;
          });
        } else {
          setState(() {
            opasiti3 = 0.5;
          });
        }
        if ((latestSuhuValue >= 20.0 && latestSuhuValue <= 24.0) ||
            (latestSuhuValue >= 80.0 && latestSuhuValue <= 85.0)) {
          setState(() {
            opasiti4 = 1;
          });
        } else {
          setState(() {
            opasiti4 = 0.5;
          });
        }
      }
    } else if (tanam == 'a') {
      setState(() {
        opasiti1 = 1;
      });
    }
  }

  void getDataSensor() {
    final ref = FirebaseDatabase.instance.ref('test');
    ref.child('Sensor Ph').onValue.listen((event1) {
      // Mengambil nilai terbaru dari Firebase dan mengupdate state
      setState(() {
        latestPhValue = event1.snapshot.value as double;
        aturOpasiti();
      });
    });
    ref.child('Sensor Kelembapan Tanah').onValue.listen((event2) {
      // Mengambil nilai terbaru dari Firebase dan mengupdate state
      setState(() {
        latestKelembapanValue = event2.snapshot.value as double;
        aturOpasiti();
      });
    });
    ref.child('Sensor Ketinggian Air').onValue.listen((event3) {
      // Mengambil nilai terbaru dari Firebase dan mengupdate state
      setState(() {
        latestKetinggianValue = event3.snapshot.value as double;
        aturOpasiti();
      });
    });
    ref.child('Sensor Suhu').onValue.listen((event4) {
      // Mengambil nilai terbaru dari Firebase dan mengupdate state
      setState(() {
        latestSuhuValue = event4.snapshot.value as double;
        aturOpasiti();
      });
    });
    aturOpasiti();
  }

  void _saveVarietas(String varietas) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('varietas', varietas);
    } catch (e) {
      print('Error while saving varietas: $e');
    }
  }

  void _sendVarietasData(
      String benih, String varietas, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int userId = pref.getInt('userId') ?? 0;

      final response = await http.post(
        Uri.parse('$baseURL/choice'),
        headers: {'Accept': 'application/json'},
        body: {
          'benih': benih,
          'varietas': varietas,
          'user_id': userId.toString()
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Berhasil memilih varietas!'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () async {
                    // Memanggil fungsi untuk menyimpan varietas dan menunggu hingga selesai
                    _saveVarietas(varietas);

                    // Menutup dialog
                    Navigator.of(context).pop();

                    // Navigasi ke halaman Persiapan setelah dialog tertutup
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Persiapan(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        final data = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Error: ' + data['message']),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
              'Something went wrong, try again!',
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _saveInfoVar(String infovar) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('infovar', infovar);
  }

  ButtonStyle kIconStyle(BuildContext context, double width, double height) {
    double fontSize = height / 2;
    return ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 210, 149, 81),
      foregroundColor: Colors.white, // Change color when button is pressed
      side: BorderSide(color: Color.fromARGB(255, 77, 39, 9), width: 2),
      fixedSize: Size(height * 7 / 2, height),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the radius as needed
      ),
      padding: EdgeInsets.symmetric(horizontal: 0), // Adjust padding as needed
    );
  }

  ButtonStyle kInfoStyle(BuildContext context, double height) {
    double fontSize = height / 2;
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Color.fromARGB(255, 77, 39, 9),
      side: BorderSide(color: Color.fromARGB(255, 77, 39, 9), width: 2),
      fixedSize: Size(height - (height / 3), height - (height / 3)),
      elevation: 0,
      shape: CircleBorder(),
      padding: EdgeInsets.symmetric(horizontal: 0), // Adjust padding as needed
      textStyle: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w700), // Set font size
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonWidth = screenWidth * 0.1; // Adjust the percentage as needed
    double maskotWidth = screenWidth * 0.20; // Adjust the percentage as needed
    double buttonHeight = screenHeight * 0.1;
    double iconSize = screenHeight * 0.12;

    return Scaffold(
        appBar: AppBar(
            title:
                Text("Varietas Jagung", style: GoogleFonts.getFont('Poppins')),
            foregroundColor: Colors.black,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              iconBar1(iconSize, opasiti1),
              iconBar2(iconSize, opasiti2),
              iconBar3(iconSize, opasiti3),
              iconBar4(iconSize, opasiti4)
            ]),
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image13,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: iconSize * 15 / 10,
              right: 0,
              left: 0,
              bottom: iconSize * 3,
              child: Container(
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                    _saveInfoVar('Jagung Lamuru');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'lamuru', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('Lamuru',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung Sukmaraga');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'sukmaraga', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('Sukmaraga',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4), //
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
                                    _saveInfoVar('Jagung Srikandi Kuning');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'srikandi kuning', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('Srikandi Kuning',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung Srikandi Putih');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'srikandi putih', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('Srikandi Putih',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung BISI 12');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'BISI 12', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('BISI 12',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung BISI 16');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'BISI 16', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('BISI 16',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: buttonHeight * 2 / 3),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                    _saveInfoVar('Jagung NK 22');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'NK 22', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('NK 22',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung NK 11');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'NK 11', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('NK 11',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung PIONEER 11');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'PIONEER 11', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('PIONEER 11',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung PIONEER 12');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'PIONEER 12', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('PIONEER 12',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung PIONEER 21');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'PIONEER 21', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('PIONEER 21',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung PIONEER 23');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'PIONEER 23 kuning', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('PIONEER 23',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: buttonHeight * 2 / 3),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                    _saveInfoVar('Jagung DK3');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData('jagung', 'DK3', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('DK3',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung Semar-8');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'semar-8', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('Semar-8',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung Semar-10');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'semar-10', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('Semar-10',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung Bima-1');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'bima-1', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('Bima-1',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
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
                                    _saveInfoVar('Jagung Bima-2 B');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InfoVar(),
                                      ),
                                    );
                                  },
                                  style: kInfoStyle(context, buttonHeight),
                                  child: Text('!'),
                                ),
                                SizedBox(width: buttonHeight / 4),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'bima-2 B', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('Bima-2 B',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                            SizedBox(height: buttonHeight / 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: buttonHeight * 2),
                                ElevatedButton(
                                  onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                                    _sendVarietasData(
                                        'jagung', 'lainnya', context);
                                  },
                                  style: kIconStyle(
                                      context, buttonWidth, buttonHeight),
                                  child: Text('Lainnya',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))),
                  Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: maskotWidth, // Lebar Container
                height: maskotWidth, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  'assets/gotan sedekap.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              )),
          Positioned(
              right: maskotWidth - (maskotWidth/4),
              bottom: iconSize/4,
              child: Container(
                width: maskotWidth, // Lebar Container
                height: maskotWidth, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  'assets/4.3 gotan-varietas jagung.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              ))
        ]));
  }
}
