import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/screen/infokhusus.dart';
import 'package:go_tani/screen/ruangkoleksi.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_tani/main.dart';

class GoReward extends StatefulWidget {
  @override
  _GoRewardState createState() => _GoRewardState();
}

class _GoRewardState extends State<GoReward> {
  double gambar1 = 1.0;
  double gambar2 = 0.5;
  double gambar3 = 0.5;
  double gambar4 = 0.5;
  double gambar5 = 0.5;
  double gambar6 = 0.5;
  double gambar7 = 0.5;
  double gambar8 = 0.5;
  double gambar9 = 0.5;
  double gambar10 = 0.5;
  double gambar11 = 0.5;
  double gambar12 = 0.5;
  double gambar13 = 1.0;
  double gambar14 = 1.0;

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
    // _loadOpacityFromSharedPreferences1();
    // _loadOpacityFromSharedPreferences2();
    // _loadOpacityFromSharedPreferences3();
    // _loadOpacityFromSharedPreferences4();
    // _loadOpacityFromSharedPreferences5();
    // _loadOpacityFromSharedPreferences6();
  }

  void _saveinfovariable(String variableinfo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('infokhusus', variableinfo);
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

  // Future<void> _loadOpacityFromSharedPreferences1() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   double bc = prefs.getDouble('bcAngka') ?? 0;
  //   if (bc > 0.25) {
  //     setState(() {
  //       gambar3 = 1.0;
  //     });
  //   } else if (bc < 0.25) {
  //     setState(() {
  //       gambar3 = 0.5;
  //     });
  //   }
  // }

  // Future<void> _loadOpacityFromSharedPreferences2() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   double bc = prefs.getDouble('bcAngka') ?? 0;
  //   if (bc > 0.50) {
  //     setState(() {
  //       gambar4 = 1.0;
  //     });
  //   } else if (bc < 0.50) {
  //     setState(() {
  //       gambar4 = 0.5;
  //     });
  //   }
  // }

  // Future<void> _loadOpacityFromSharedPreferences3() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   double bc = prefs.getDouble('bcAngka') ?? 0;
  //   if (bc > 0.75) {
  //     setState(() {
  //       gambar5 = 1.0;
  //     });
  //   } else if (bc < 0.75) {
  //     setState(() {
  //       gambar5 = 0.5;
  //     });
  //   }
  // }

  // Future<void> _loadOpacityFromSharedPreferences4() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   double bc = prefs.getDouble('bcAngka') ?? 0;
  //   if (bc > 1) {
  //     setState(() {
  //       gambar6 = 1.0;
  //     });
  //   } else if (bc < 0.75) {
  //     setState(() {
  //       gambar6 = 0.5;
  //     });
  //   }
  // }

  // Future<void> _loadOpacityFromSharedPreferences5() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String mulai = prefs.getString('mulai') ?? '';
  //   String rute = (mulai.isEmpty) ? 'a' : 'b';

  //   if (rute == 'a') {
  //     setState(() {
  //       gambar1 = 0.5;
  //     });
  //   } else {
  //     setState(() {
  //       gambar1 = 1;
  //     });
  //   }
  // }

  // Future<void> _loadOpacityFromSharedPreferences6() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String panen = prefs.getString('panen') ?? '';
  //   String rute = (panen.isEmpty) ? 'a' : 'b';

  //   if (rute == 'a') {
  //     setState(() {
  //       gambar2 = 0.5;
  //     });
  //   } else {
  //     setState(() {
  //       gambar2 = 1;
  //     });
  //   }
  // }

  Widget rewardPic(String lokasi, double aktif) {
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonHeight = screenHeight * 0.20;
    return Container(
      height: buttonHeight * 17 / 10,
      width: buttonHeight * 17 / 10,
      color: Colors.transparent,
      child: Opacity(
          opacity: aktif, child: Image.asset(lokasi, fit: BoxFit.contain)),
    );
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenHeight * 0.12;
    double buttonHeight = screenHeight * 0.12;
    double maskotSize = screenHeight * 0.20;
    double containerWidth = screenWidth * 90 / 100;
    double containerHeight = screenHeight * 90 / 100;

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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image21,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: iconSize * 15 / 10,
              right: (buttonHeight * 3) - (iconSize * 2),
              left: (buttonHeight * 3) + (iconSize * 5 / 2),
              bottom: iconSize,
              child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 199, 116),
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SingleChildScrollView(
                      child: Container(
                          decoration: BoxDecoration(
                            color:
                                Colors.transparent, // Warna latar belakang baru
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: EdgeInsets.fromLTRB(
                              iconSize, iconSize / 2, iconSize, iconSize / 2),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: iconSize,
                                      height: iconSize,
                                      child:
                                          rewardPic('assets/xp.png', gambar13),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        color: Colors.transparent,
                                        width: iconSize,
                                        height: iconSize,
                                        child: Text('0 xp',
                                            style: GoogleFonts.getFont(
                                                'Poppins',
                                                color: Colors.black))),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Ayo kumpulkan xp sebanyak-banyaknya untuk membuka reward mulai dari Beginner sampai Proficient!\n\nCaranya adalah dengan menyelesaikan misi-misi kecil yang bisa kamu cek di bawah",
                                  style: GoogleFonts.getFont("Poppins",
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          color: Colors.transparent,
                                          width: maskotSize * 17 / 10,
                                          height: maskotSize * 17 / 10,
                                          child: rewardPic(
                                              'assets/72.png', gambar1),
                                        ),
                                      ],
                                    ),
                                    Stack(children: [
                                      Container(
                                        color: Colors.transparent,
                                        width: maskotSize * 17 / 10,
                                        height: maskotSize * 17 / 10,
                                        child:
                                            rewardPic('assets/73.png', gambar2),
                                      ),
                                      Positioned(
                                        top: maskotSize *
                                            (17 / 10 - 17 / 30) /
                                            2, // Posisi vertikal di tengah
                                        left: maskotSize *
                                            (17 / 10 - 17 / 30) /
                                            2, // Posisi horizontal di tengah
                                        child: Container(
                                          color: Colors.transparent,
                                          width: maskotSize *
                                              17 /
                                              30, // Lebar gembok yang lebih kecil
                                          height: maskotSize *
                                              17 /
                                              30, // Tinggi gembok yang lebih kecil
                                          child: rewardPic(
                                              'assets/gembok.png', gambar14),
                                        ),
                                      ),
                                    ]),
                                    Stack(children: [
                                      Container(
                                        color: Colors.transparent,
                                        width: maskotSize * 17 / 10,
                                        height: maskotSize * 17 / 10,
                                        child:
                                            rewardPic('assets/74.png', gambar3),
                                      ),
                                      Positioned(
                                        top: maskotSize *
                                            (17 / 10 - 17 / 30) /
                                            2, // Posisi vertikal di tengah
                                        left: maskotSize *
                                            (17 / 10 - 17 / 30) /
                                            2, // Posisi horizontal di tengah
                                        child: Container(
                                          color: Colors.transparent,
                                          width: maskotSize *
                                              17 /
                                              30, // Lebar gembok yang lebih kecil
                                          height: maskotSize *
                                              17 /
                                              30, // Tinggi gembok yang lebih kecil
                                          child: rewardPic(
                                              'assets/gembok.png', gambar14),
                                        ),
                                      ),
                                    ])
                                  ],
                                ),
                                SizedBox(
                                  height: iconSize / 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(children: [
                                      Container(
                                        color: Colors.transparent,
                                        width: maskotSize * 17 / 10,
                                        height: maskotSize * 17 / 10,
                                        child:
                                            rewardPic('assets/75.png', gambar4),
                                      ),
                                      Positioned(
                                        top: maskotSize *
                                            (17 / 10 - 17 / 30) /
                                            2, // Posisi vertikal di tengah
                                        left: maskotSize *
                                            (17 / 10 - 17 / 30) /
                                            2, // Posisi horizontal di tengah
                                        child: Container(
                                          color: Colors.transparent,
                                          width: maskotSize *
                                              17 /
                                              30, // Lebar gembok yang lebih kecil
                                          height: maskotSize *
                                              17 /
                                              30, // Tinggi gembok yang lebih kecil
                                          child: rewardPic(
                                              'assets/gembok.png', gambar14),
                                        ),
                                      ),
                                    ]),
                                    Stack(children: [
                                      Container(
                                        color: Colors.transparent,
                                        width: maskotSize * 17 / 10,
                                        height: maskotSize * 17 / 10,
                                        child:
                                            rewardPic('assets/76.png', gambar5),
                                      ),
                                      Positioned(
                                        top: maskotSize *
                                            (17 / 10 - 17 / 30) /
                                            2, // Posisi vertikal di tengah
                                        left: maskotSize *
                                            (17 / 10 - 17 / 30) /
                                            2, // Posisi horizontal di tengah
                                        child: Container(
                                          color: Colors.transparent,
                                          width: maskotSize *
                                              17 /
                                              30, // Lebar gembok yang lebih kecil
                                          height: maskotSize *
                                              17 /
                                              30, // Tinggi gembok yang lebih kecil
                                          child: rewardPic(
                                              'assets/gembok.png', gambar14),
                                        ),
                                      ),
                                    ]),
                                    Stack(children: [
                                      Container(
                                        color: Colors.transparent,
                                        width: maskotSize * 17 / 10,
                                        height: maskotSize * 17 / 10,
                                        child:
                                            rewardPic('assets/77.png', gambar6),
                                      ),
                                      Positioned(
                                        top: maskotSize *
                                            (17 / 10 - 17 / 30) /
                                            2, // Posisi vertikal di tengah
                                        left: maskotSize *
                                            (17 / 10 - 17 / 30) /
                                            2, // Posisi horizontal di tengah
                                        child: Container(
                                          color: Colors.transparent,
                                          width: maskotSize *
                                              17 /
                                              30, // Lebar gembok yang lebih kecil
                                          height: maskotSize *
                                              17 /
                                              30, // Tinggi gembok yang lebih kecil
                                          child: rewardPic(
                                              'assets/gembok.png', gambar14),
                                        ),
                                      ),
                                    ])
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: maskotSize * 17 / 20,
                                      height: maskotSize * 17 / 20,
                                      child: rewardPic(
                                          'assets/capil sepuh.png', gambar7),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      width: ((maskotSize * 17 / 10) * 2) +
                                          (maskotSize * 17 / 20),
                                      height: maskotSize * 17 / 20,
                                      child: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.black,
                                              fontSize: 10),
                                          children: const <TextSpan>[
                                            TextSpan(
                                              text: 'Cara mendapatkan ',
                                            ),
                                            TextSpan(
                                              text: 'Caping Hero',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' adalah dengan menanam padi untuk pertama kali. Berhadiah 10xp',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: maskotSize * 17 / 20,
                                      height: maskotSize * 17 / 20,
                                      child: rewardPic(
                                          'assets/garukan tanah.png', gambar8),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      width: ((maskotSize * 17 / 10) * 2) +
                                          (maskotSize * 17 / 20),
                                      height: maskotSize * 17 / 20,
                                      child: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.black,
                                              fontSize: 10),
                                          children: const <TextSpan>[
                                            TextSpan(
                                              text: 'Cara mendapatkan ',
                                            ),
                                            TextSpan(
                                              text: 'Garu Galor',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' adalah dengan menanyakan 5 pertanyaan di Go-Ask yang relevan dengan pertanian. Berhadiah 25xp',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: maskotSize * 17 / 20,
                                      height: maskotSize * 17 / 20,
                                      child: rewardPic(
                                          'assets/pacul penggali kubur.png',
                                          gambar9),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      width: ((maskotSize * 17 / 10) * 2) +
                                          (maskotSize * 17 / 20),
                                      height: maskotSize * 17 / 20,
                                      child: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.black,
                                              fontSize: 10),
                                          children: const <TextSpan>[
                                            TextSpan(
                                              text: 'Cara mendapatkan ',
                                            ),
                                            TextSpan(
                                              text: 'Cangkul Quest',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' adalah dengan menanyakan 15 pertanyaan di Go-Ask yang relevan dengan pertanian. Berhadiah 75xp',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: maskotSize * 17 / 20,
                                      height: maskotSize * 17 / 20,
                                      child: rewardPic(
                                          'assets/gembor rare sedunia.png',
                                          gambar11),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      width: ((maskotSize * 17 / 10) * 2) +
                                          (maskotSize * 17 / 20),
                                      height: maskotSize * 17 / 20,
                                      child: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.black,
                                              fontSize: 10),
                                          children: const <TextSpan>[
                                            TextSpan(
                                              text: 'Cara mendapatkan ',
                                            ),
                                            TextSpan(
                                              text: 'Gembor Guardians',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' adalah dengan mencatat semua pendapatan yang diperoleh ketika panen. Berhadiah 50xp',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: maskotSize * 17 / 20,
                                      height: maskotSize * 17 / 20,
                                      child: rewardPic(
                                          'assets/sepatu boood.png', gambar12),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      width: ((maskotSize * 17 / 10) * 2) +
                                          (maskotSize * 17 / 20),
                                      height: maskotSize * 17 / 20,
                                      child: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.black,
                                              fontSize: 10),
                                          children: const <TextSpan>[
                                            TextSpan(
                                              text: 'Cara mendapatkan ',
                                            ),
                                            TextSpan(
                                              text: 'Boot Blitzer',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' adalah dengan mencapai tahap Pemeliharaan pada Go-Process. Berhadiah 20xp',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: maskotSize * 17 / 20,
                                      height: maskotSize * 17 / 20,
                                      child: rewardPic(
                                          'assets/transformer sawah.png',
                                          gambar10),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      width: ((maskotSize * 17 / 10) * 2) +
                                          (maskotSize * 17 / 20),
                                      height: maskotSize * 17 / 20,
                                      child: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.black,
                                              fontSize: 10),
                                          children: const <TextSpan>[
                                            TextSpan(
                                              text: 'Cara mendapatkan ',
                                            ),
                                            TextSpan(
                                              text: 'Traktor Adventure',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' adalah dengan membaca semua panduan pertanian sampai panen dengan cermat. Berhadiah 100xp',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            RuangKoleksi(),
                                      ),
                                    );
                                  },
                                  style: kButtonStyle(
                                      context, iconSize * 3 / 2, iconSize),
                                  child: Text('Ruang Koleksi',
                                      style: GoogleFonts.getFont('Poppins')),
                                ),
                              ]))))),
          // Positioned(
          //     right: iconSize * 2,
          //     top: iconSize*34/10,
          //     child: Container(
          //       height: iconSize * 2,
          //       width: iconSize * 2,
          //       color: Colors.transparent,
          //       child: IconButton(
          //         onPressed: () {
          //           final klik = AudioPlayer();
          //           klik.setVolume(1.0);
          //           klik.play(
          //             AssetSource('click.mp3'),
          //           );
          //           _saveinfovariable('reward');
          //           Navigator.push(
          //             context,
          //             PageRouteBuilder(
          //               pageBuilder: (context, animation, secondaryAnimation) =>
          //                   InfoKhusus(),
          //             ),
          //           );
          //         },
          //         icon: image10,
          //       ),
          //     ))
        ],
      ),
    );
  }
}
