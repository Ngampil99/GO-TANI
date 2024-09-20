import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/screen/infokhusus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pemeliharaan extends StatefulWidget {
  @override
  _PemeliharaanState createState() => _PemeliharaanState();
}

class _PemeliharaanState extends State<Pemeliharaan> {
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

  void _saveinfovariable(String variableinfo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('infokhusus', variableinfo);
  }


  Widget sensor(String nama, double height, double width) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.black, width: 2)),
      color: const Color.fromARGB(255, 226, 199, 116),
      height: height,
      width: width,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: Text(nama,
          style: GoogleFonts.getFont('Poppins'), textAlign: TextAlign.left),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonWidth = screenWidth * 0.25;
    double maskotWidth = screenWidth * 0.20;
    double buttonHeight = screenHeight * 0.20;
    double containerWidth = screenWidth * 90 / 100;
    double containerHeight = screenHeight * 90 / 100;
    double iconSize = screenHeight * 0.12;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Tahap Pemeliharaan",
            style: GoogleFonts.getFont('Poppins'),
          ),
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
              top: iconSize * 15 / 10,
              bottom: iconSize * 3,
              left: iconSize * 3/2,
              right: iconSize * 3/2,
              child: Container(
                  color: Colors.transparent,
                  child: Container(
                    width: containerWidth * 8 / 10,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 121, 68, 28),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.all(0),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            sensor(
                                'pH Tanah', iconSize, containerWidth * 7 / 20),
                            SizedBox(
                              width: iconSize / 2,
                            ),
                            sensor('$latestPhValue', iconSize,
                                containerWidth * 7 / 40),
                          ]),
                          SizedBox(
                            height: iconSize,
                          ),
                          Row(children: [
                            sensor('Kelembaban Tanah', iconSize,
                                containerWidth * 7 / 20),
                            SizedBox(
                              width: iconSize / 2,
                            ),
                            sensor('$latestKelembapanValue', iconSize,
                                containerWidth * 7 / 40),
                          ]),
                          SizedBox(
                            height: iconSize,
                          ),
                          Row(children: [
                            sensor('Ketinggian Air', iconSize,
                                containerWidth * 7 / 20),
                            SizedBox(
                              width: iconSize / 2,
                            ),
                            sensor('$latestKetinggianValue', iconSize,
                                containerWidth * 7 / 40),
                          ]),
                          SizedBox(
                            height: iconSize,
                          ),
                          Row(children: [
                            sensor('Suhu Tanah', iconSize,
                                containerWidth * 7 / 20),
                            SizedBox(
                              width: iconSize / 2,
                            ),
                            sensor('$latestSuhuValue', iconSize,
                                containerWidth * 7 / 40),
                          ]),
                        ],
                      ),
                    ),
                  ))),
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
                    _saveinfovariable('pemeliharaan');
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
            top: buttonHeight,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: maskotWidth, // Lebar Container
                height: maskotWidth, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  'assets/ani sedekap.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              )),
          Positioned(
              right: maskotWidth * 3 / 4,
              bottom: 0,
              child: Container(
                width: maskotWidth, // Lebar Container
                height: maskotWidth, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  'assets/8. ani-pemeliharaan tanaman.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              ))
        ],
      ),
    );
  }
}
