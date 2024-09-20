// ignore_for_file: unnecessary_import, unused_local_variable

import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/screen/go_process/persiapan_varietas/infovarpadi.dart';
import 'package:go_tani/screen/infokhusus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_tani/screen/go_process/persiapan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VarietasPadi extends StatefulWidget {
  @override
  _VarietasPadiState createState() => _VarietasPadiState();
}

class _VarietasPadiState extends State<VarietasPadi> {

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
    String mulai2 = prefs.getString('mulai2') ??
        '';
    String tanam = (mulai2.isEmpty) ? 'a' : 'b';
    if (tanam == 'b') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String benih = prefs.getString('benih') ?? '';
      if (benih == 'padi') {
        if ( (latestPhValue >= 4.5 && latestPhValue <= 5.5) || (latestPhValue >= 7.0 && latestPhValue <= 8.0)) {
          setState(() {
            opasiti1 = 1;
          });}
        else {
          setState(() {
            opasiti1 = 0.5;
          });
        }
        if ( latestKelembapanValue >= 30.0 && latestKelembapanValue <= 33.0) {
          setState(() {
            opasiti2 = 1;
          });
        } 
        else {
          setState(() {
            opasiti2 = 0.5;
          });
        }
        if ( latestKetinggianValue >= 30.0 && latestKetinggianValue <= 33.0) {
          setState(() {
            opasiti3 = 1;
          });
        } else {
          setState(() {
            opasiti3 = 0.5;
          });
        }
        if ( (latestSuhuValue >= 22.0 && latestSuhuValue <= 24.0) || (latestSuhuValue >= 29.0 && latestSuhuValue <= 32.0)) {
          setState(() {
            opasiti4 = 1;
          });
        } 
        else {
          setState(() {
            opasiti4 = 0.5;
          });
        }
        }else if(benih == 'jagung') { //If else untuk benih jagung
        if ( (latestPhValue >= 5.5 && latestPhValue <= 5.8) || (latestPhValue >= 7.8 && latestPhValue <= 8.2)) {
          setState(() {
            opasiti1 = 1;
          });
        } else {
          setState(() {
            opasiti1 = 0.5;
          });
        }
        if ( latestKelembapanValue >= 36.0 && latestKelembapanValue <= 42.0) {
          setState(() {
            opasiti2 = 1;
          });
        } else {
          setState(() {
            opasiti2 = 0.5;
          });
        }
        if ( latestKetinggianValue >= 30.0 && latestKetinggianValue <= 33.0) {
          setState(() {
            opasiti3 = 1;
          });
        } else {
          setState(() {
            opasiti3 = 0.5;
          });
        }
        if ( latestSuhuValue >= 26.0 && latestSuhuValue <= 30.0) {
          setState(() {
            opasiti4 = 1;
          });
        } else {
          setState(() {
            opasiti4 = 0.5;
          });
        }
      } else if(benih == 'kacang tanah') {
        if ( (latestPhValue >= 5.0 && latestPhValue <= 6.0) || (latestPhValue >= 7.0 && latestPhValue <= 7.5)) {
          setState(() {
            opasiti1 = 1;
          });
        } else {
          setState(() {
            opasiti1 = 0.5;
          });
        }
        if ( latestKelembapanValue > 80.0 || latestKelembapanValue < 80.0) {
          setState(() {
            opasiti2 = 1;
          });
        } else {
          setState(() {
            opasiti2 = 0.5;
          });
        }
        if ( latestKetinggianValue >= 30.0 && latestKetinggianValue <= 33.0) {
          setState(() {
            opasiti3 = 1;
          });
        } else {
          setState(() {
            opasiti3 = 0.5;
          });
        }
        if ( (latestSuhuValue >= 20.0 && latestSuhuValue <= 25.0) || (latestSuhuValue >= 27.0 && latestSuhuValue <= 30.0)) {
          setState(() {
            opasiti4 = 1;
          });
        } else {
          setState(() {
            opasiti4 = 0.5;
          });
        }
      } else if(benih=='kedelai') {
        if ( (latestPhValue >= 5.0 && latestPhValue <= 5.5) || (latestPhValue >= 7.5 && latestPhValue <= 7.8)) {
          setState(() {
            opasiti1 = 1;
          });
        } else {
          setState(() {
            opasiti1 = 0.5;
          });
        }
        if ( latestKelembapanValue > 80.0 && latestKelembapanValue < 50.0) {
          setState(() {
            opasiti2 = 1;
          });
        } else {
          setState(() {
            opasiti2 = 0.5;
          });
        }
        if ( latestKetinggianValue >= 30.0 && latestKetinggianValue <= 33.0) {
          setState(() {
            opasiti3 = 1;
          });
        } else {
          setState(() {
            opasiti3 = 0.5;
          });
        }
        if ( (latestSuhuValue >= 20.0 && latestSuhuValue <= 24.0) || (latestSuhuValue >= 80.0 && latestSuhuValue <= 85.0)) {
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

  void _saveinfovariable(String variableinfo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('infokhusus', variableinfo);
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
      fixedSize: Size(height * 3, height),
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
          title: Text("Varietas Padi",style: GoogleFonts.getFont('Poppins')),
          foregroundColor: Colors.black,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [iconBar1(iconSize,opasiti1),iconBar2(iconSize, opasiti2),iconBar3(iconSize, opasiti3),iconBar4(iconSize, opasiti4)]
        ),
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
            top: iconSize* 17/10,
            left: 0,
            right: 0,
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
                            _saveInfoVar('Padi Hibrida');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoVarPadi(),
                              ),
                            );
                          },
                          style: kInfoStyle(context, buttonHeight),
                          child: Text('!'),
                        ),
                        SizedBox(width: buttonHeight/4),
                        ElevatedButton(
                          onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                            _sendVarietasData('padi', 'hibrida', context);
                          },
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: Text('Hibrida',style: GoogleFonts.getFont('Poppins')),
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
                            _saveInfoVar('Padi Unggul');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoVarPadi(),
                              ),
                            );
                          },
                          style: kInfoStyle(context, buttonHeight),
                          child: Text('!'),
                        ),
                        SizedBox(width: buttonHeight/4),
                        ElevatedButton(
                          onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                            _sendVarietasData('padi', 'unggul', context);
                          },
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: Text('Unggul',style: GoogleFonts.getFont('Poppins')),
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
                            _saveInfoVar('Padi Lokal');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoVarPadi(),
                              ),
                            );
                          },
                          style: kInfoStyle(context, buttonHeight),
                          child: Text('!'),
                        ),
                        SizedBox(width: buttonHeight/4),
                        ElevatedButton(
                          onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                            _sendVarietasData('padi', 'lokal', context);
                          },
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: Text('Lokal',style: GoogleFonts.getFont('Poppins')),
                        ),
                      ],
                    ),
                    SizedBox(height: buttonHeight/4),
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
                            _saveInfoVar('Padi Ketan');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoVarPadi(),
                              ),
                            );
                          },
                          style: kInfoStyle(context, buttonHeight),
                          child: Text('!'),
                        ),
                        SizedBox(width: buttonHeight/4),
                        ElevatedButton(
                          onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                            _sendVarietasData('padi', 'ketan', context);
                          },
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: Text('Ketan',style: GoogleFonts.getFont('Poppins')),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: buttonHeight*2),
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
                            _saveInfoVar('Padi Wangi');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoVarPadi(),
                              ),
                            );
                          },
                          style: kInfoStyle(context, buttonHeight),
                          child: Text('!'),
                        ),
                        SizedBox(width: buttonHeight/4),
                        ElevatedButton(
                          onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                            _sendVarietasData('padi', 'wangi', context);
                          },
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: Text('Wangi',style: GoogleFonts.getFont('Poppins')),
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
                            _saveInfoVar('Padi Pera');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoVarPadi(),
                              ),
                            );
                          },
                          style: kInfoStyle(context, buttonHeight),
                          child: Text('!'),
                        ),
                        SizedBox(width: buttonHeight/4),
                        ElevatedButton(
                          onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                            _sendVarietasData('padi', 'pera', context);
                          },
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: Text('Pera',style: GoogleFonts.getFont('Poppins')),
                        ),
                      ],
                    ),
                    SizedBox(height: buttonHeight / 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: buttonHeight*2),
                        ElevatedButton(
                          onPressed: () {
                                    final klik = AudioPlayer();
                                    klik.setVolume(1.0);
                                    klik.play(
                                      AssetSource('click.mp3'),
                                    );
                            _sendVarietasData('padi', 'lainnya', context);
                          },
                          style: kIconStyle(context, buttonWidth, buttonHeight),
                          child: Text('Lainnya',style: GoogleFonts.getFont('Poppins')),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                    _saveinfovariable('pemilihan varietas');
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
              right: maskotWidth - (maskotWidth/3),
              bottom: iconSize/4,
              child: Container(
                width: maskotWidth, // Lebar Container
                height: maskotWidth, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  'assets/4.1 gotan-varietas padi.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              ))
        ]));
  }
}
