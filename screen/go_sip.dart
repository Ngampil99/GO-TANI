import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoSip extends StatefulWidget {
  @override
  _GoSipState createState() => _GoSipState();
}

class _GoSipState extends State<GoSip> {
  TextEditingController stringInput1Controller = TextEditingController();
  TextEditingController stringInput2Controller = TextEditingController();

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

  void updateTextField2BasedOnTextField1() {
    String input1Text = stringInput1Controller.text.toLowerCase(); // Mengambil teks dari TextField pertama dan mengubahnya menjadi huruf kecil
    String newText2 = '';

    if (input1Text.contains('padi') && input1Text.contains('varietas') && input1Text.contains('umum') && input1Text.contains('berapa')) {
      newText2 = 'Ada 6 varietas';
    } else if(input1Text.contains('padi') && input1Text.contains('varietas') && input1Text.contains('umum') && input1Text.contains('apa saja')){
      newText2 = 'Ada varietas Pera, Wangi, Ketan, Lokal, Unggul, dan Hibrida';
    }
    stringInput2Controller.text = newText2;
  }

  void _jawaban() {
    final klik = AudioPlayer();
    klik.setVolume(1.0);
    klik.play(
      AssetSource('click.mp3'),
    );
    updateTextField2BasedOnTextField1();
  }

  void _hapus() {
    final klik = AudioPlayer();
    klik.setVolume(1.0);
    klik.play(
      AssetSource('click.mp3'),
    );
    stringInput1Controller.text = '';
    stringInput2Controller.text = '';
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
      padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust padding as needed
      textStyle: GoogleFonts.getFont('Poppins',
          fontSize: fontSize, fontWeight: FontWeight.w600), // Set font size
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth * 90 / 100;
    double containerHeight = screenHeight * 90 / 100;
    double iconSize = screenHeight * 0.12;

    return Scaffold(
        appBar: AppBar(
            title: Text("Go-Ask", style: GoogleFonts.getFont('Poppins')),
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
                top: iconSize * 17 / 10,
                left: 0,
                right: 0,
                child: Column(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: containerHeight * 1 / 2,
                          width: containerWidth * 8 / 10,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 121, 68, 28),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.fromLTRB(iconSize,
                                  iconSize / 2, iconSize, iconSize / 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: containerWidth * 4 / 10,
                                          child: TextField(
                                            controller: stringInput1Controller,
                                            decoration: InputDecoration(
                                              labelText: 'Tanyakan di Sini',
                                              fillColor: const Color.fromARGB(
                                                  255, 226, 199, 116),
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              enabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              ),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              ),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              labelStyle: GoogleFonts.getFont(
                                                'Poppins',
                                                color: Colors.black,
                                                fontSize: 10,
                                              ),
                                            ),
                                            cursorColor: Colors.black,
                                            maxLines: null, // Tinggi dinamis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: iconSize / 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: containerWidth * 4 / 10,
                                          child: TextField(
                                            controller: stringInput2Controller,
                                            decoration: InputDecoration(
                                              labelText:
                                                  'Jawabannya di Sini',
                                              fillColor: const Color.fromARGB(
                                                  255, 226, 199, 116),
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              enabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              ),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              ),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              labelStyle: GoogleFonts.getFont(
                                                'Poppins',
                                                color: Colors.black,
                                                fontSize: 10,
                                              ),
                                            ),
                                            cursorColor: Colors.black,
                                            maxLines: null, // Tinggi dinamis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                  SizedBox(height: iconSize / 3),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: _jawaban,
                                    style: kButtonStyle(
                                        context, iconSize * 3 / 2, iconSize),
                                    child: Text('Tanyakan',
                                        style: GoogleFonts.getFont('Poppins')),
                                  ),
                                  SizedBox(
                                      width: iconSize /
                                          2), // Jarak antara dua tombol
                                  ElevatedButton(
                                    onPressed: () {
                                      _hapus();
                                    },
                                    style: kButtonStyle(
                                        context, iconSize * 3 / 2, iconSize),
                                    child: Text('Hapus',
                                        style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ]),
                          ],
                        ),
                      ])
                ]))
          ],
        ));
  }
}
