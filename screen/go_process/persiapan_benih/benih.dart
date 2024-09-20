// ignore_for_file: unnecessary_import, unused_local_variable

import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/screen/go_process/persiapan_benih/infobenih.dart';
import 'package:go_tani/screen/go_process/persiapan_varietas/varietasjagung.dart';
import 'package:go_tani/screen/go_process/persiapan_varietas/varietaskacang.dart';
import 'package:go_tani/screen/go_process/persiapan_varietas/varietaskedelai.dart';
import 'package:go_tani/screen/go_process/persiapan_varietas/varietaspadi.dart';
import 'package:go_tani/screen/infokhusus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_tani/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Benih extends StatefulWidget {
  @override
  _BenihState createState() => _BenihState();
}

class _BenihState extends State<Benih> {
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

// Dipakai untuk menyimpan nilai benih ke preferred
  void _saveBenih(String benih) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('benih', benih);
  }

  void _saveInfoBenih(String infobenih) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('infobenih', infobenih);
  }

  void _sendBenihData(String benih, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int userId = pref.getInt('userId') ?? 0;

      final response = await http.post(
        Uri.parse('$baseURL/choice'),
        headers: {'Accept': 'application/json'},
        body: {'benih': benih, 'user_id': userId.toString()},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Berhasil memilih benih!'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    // digunakan untuk memanggil function _saveVarietas
                    _saveBenih(benih);
                    Navigator.of(context).pop();
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
            content: Text('Something went wrong, try again!'),
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

  ButtonStyle kIconStyle(BuildContext context, double width, double height) {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 226, 199, 116),
      side: const BorderSide(color: Color.fromARGB(255, 77, 39, 9), width: 2),
      fixedSize: Size(height * 8 / 5, height * 8 / 5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the radius as needed
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 0), // Adjust padding as needed
    );
  }

  ButtonStyle kOptionStyle(BuildContext context, double width, double height) {
    double fontSize =
        height * 0.3; // Adjust the percentage as needed for font size
    return ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      foregroundColor: Colors.black, // Change color when button is pressed
      side: const BorderSide(color: Color.fromARGB(255, 77, 39, 9), width: 2),
      fixedSize: Size(width - height, height),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the radius as needed
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 0), // Adjust padding as needed
      textStyle: GoogleFonts.getFont('Poppins',
          fontSize: fontSize, fontWeight: FontWeight.w600), // Set font size
    );
  }

  ButtonStyle kInfoStyle(BuildContext context, double height) {
    double fontSize = height / 2;
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Color.fromARGB(255, 77, 39, 9),
      side: const BorderSide(color: Color.fromARGB(255, 77, 39, 9), width: 2),
      fixedSize: Size(height - (height / 3), height - (height / 3)),
      elevation: 0,
      shape: const CircleBorder(),
      padding:
          const EdgeInsets.symmetric(horizontal: 0), // Adjust padding as needed
      textStyle: GoogleFonts.getFont('Poppins',
          fontSize: fontSize, fontWeight: FontWeight.w700), // Set font size
    );
  }

  ButtonStyle kChooseStyle(BuildContext context, double width, double height) {
    double fontSize =
        height * 0.3; // Adjust the percentage as needed for font size
    return ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 210, 149, 81),
      foregroundColor: Colors.white,
      side: const BorderSide(color: Color.fromARGB(255, 77, 39, 9), width: 2),
      fixedSize: Size(width - (height * 2), height),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the radius as needed
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 0), // Adjust padding as needed
      textStyle: GoogleFonts.getFont('Poppins',
          fontSize: fontSize, fontWeight: FontWeight.w600), // Set font size
    );
  }

  void _saveinfovariable(String variableinfo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('infokhusus', variableinfo);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonWidth = screenWidth * 0.18; // Adjust the percentage as needed
    double buttonHeight = screenHeight * 0.10;
    double iconSize = screenHeight * 0.12;
    return Scaffold(
        appBar: AppBar(
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
            top: iconSize * 3 / 2,
            bottom: 0,
            left: 50,
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
                          onPressed: () {},
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: Image.asset(
                            'assets/padi.png',
                            width:
                                buttonWidth,
                            height:
                                buttonHeight,
                            fit: BoxFit.contain,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style:
                              kOptionStyle(context, buttonWidth, buttonHeight),
                          child: const Text('Padi'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final klik = AudioPlayer();
                            klik.setVolume(1.0);
                            klik.play(
                              AssetSource('click.mp3'),
                            );
                            _saveInfoBenih('Padi');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoBenih(),
                              ),
                            );
                          },
                          style: kInfoStyle(context, buttonHeight),
                          child: const Text('!'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final klik = AudioPlayer();
                            klik.setVolume(1.0);
                            klik.play(
                              AssetSource('click.mp3'),
                            );
                            // panggil method _sendBenihData dan mengisi parameter sesuai input
                            _sendBenihData('padi', context);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        VarietasPadi(),
                              ),
                            );
                          },
                          style:
                              kChooseStyle(context, buttonWidth, buttonHeight),
                          child: Text('Pilih'),
                        ),
                      ],
                    ),
                    SizedBox(height: buttonHeight / 8), //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                            'assets/jagung.png',
                            width:
                                buttonWidth,
                            height:
                                buttonHeight,
                            fit: BoxFit.contain,
                          ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style:
                              kOptionStyle(context, buttonWidth, buttonHeight),
                          child: const Text('jagung'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final klik = AudioPlayer();
                            klik.setVolume(1.0);
                            klik.play(
                              AssetSource('click.mp3'),
                            );
                            _saveInfoBenih('Jagung');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoBenih(),
                              ),
                            );
                          },
                          style: kInfoStyle(context, buttonHeight),
                          child: Text('!'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final klik = AudioPlayer();
                            klik.setVolume(1.0);
                            klik.play(
                              AssetSource('click.mp3'),
                            );
                            // panggil method _sendBenihData dan mengisi parameter sesuai input
                            _sendBenihData('jagung', context);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        VarietasJagung(),
                              ),
                            );
                          },
                          style:
                              kChooseStyle(context, buttonWidth, buttonHeight),
                          child: const Text('Pilih'),
                        ),
                      ],
                    ),
                    SizedBox(height: buttonHeight / 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                            'assets/kedelai.png',
                            width:
                                buttonWidth,
                            height:
                                buttonHeight,
                            fit: BoxFit.contain,
                          ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style:
                              kOptionStyle(context, buttonWidth, buttonHeight),
                          child: const Text('Kedelai'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final klik = AudioPlayer();
                            klik.setVolume(1.0);
                            klik.play(
                              AssetSource('click.mp3'),
                            );
                            _saveInfoBenih('Kedelai');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoBenih(),
                              ),
                            );
                          },
                          style: kInfoStyle(context, buttonHeight),
                          child: Text('!'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final klik = AudioPlayer();
                            klik.setVolume(1.0);
                            klik.play(
                              AssetSource('click.mp3'),
                            );
                            // panggil method _sendBenihData dan mengisi parameter sesuai input
                            _sendBenihData('kedelai', context);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        VarietasKedelai(),
                              ),
                            );
                          },
                          style:
                              kChooseStyle(context, buttonWidth, buttonHeight),
                          child: const Text('Pilih'),
                        ),
                      ],
                    ),
                    SizedBox(height: buttonHeight / 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                            'assets/kacang tanah.png',
                            width:
                                buttonWidth,
                            height:
                                buttonHeight,
                            fit: BoxFit.contain,
                          ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style:
                              kOptionStyle(context, buttonWidth, buttonHeight),
                          child: const Text('Kacang Tanah'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final klik = AudioPlayer();
                            klik.setVolume(1.0);
                            klik.play(
                              AssetSource('click.mp3'),
                            );
                            _saveInfoBenih('Kacang Tanah');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoBenih(),
                              ),
                            );
                          },
                          style: kInfoStyle(context, buttonHeight),
                          child: Text('!'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final klik = AudioPlayer();
                            klik.setVolume(1.0);
                            klik.play(
                              AssetSource('click.mp3'),
                            );
                            // panggil method _sendBenihData dan mengisi parameter sesuai input
                            _sendBenihData('kacang tanah', context);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        VarietasKacang(),
                              ),
                            );
                          },
                          style:
                              kChooseStyle(context, buttonWidth, buttonHeight),
                          child: const Text('Pilih'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
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
              bottom: iconSize,
              child: Container(
                width: buttonWidth*15/10, // Lebar Container
                height: buttonWidth*15/10, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  'assets/3. gotan-pilih benih.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              )),
              Positioned(
              right: iconSize / 4,
              top: iconSize * 15 / 10,
              child: Container(
                height: iconSize * 7/2,
                width: iconSize * 7/2,
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    final klik = AudioPlayer();
                    klik.setVolume(1.0);
                    klik.play(
                      AssetSource('click.mp3'),
                    );
                    _saveinfovariable('pemilihan benih');
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            InfoKhusus(),
                      ),
                    );
                  },
                  icon: image10,
                ),
              )),
        ]));
  }
}
