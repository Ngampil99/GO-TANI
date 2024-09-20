import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PemupukanJagung extends StatefulWidget {
  @override
  _PemupukanJagungState createState() => _PemupukanJagungState();
}

class _PemupukanJagungState extends State<PemupukanJagung> {
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth * 90 / 100;
    double containerHeight = screenHeight * 90 / 100;
    double iconSize = screenHeight * 0.12;
    double maskotWidth = screenWidth * 0.20;

    return Scaffold(
      appBar: AppBar(
          title: Text('Jadwal dan Dosis Pemupukan',
              style: GoogleFonts.getFont('Poppins')),
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
              child: Container(
                width: containerWidth * 8 / 10,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 226, 199, 116), // Warna latar belakang baru
                  border: Border.all(
                    color: Colors.black, // Warna outline
                    width: 2.0, // Lebar outline
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(containerHeight / 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(0, 0, 0, containerHeight / 50),
                        child: Text(
                          "*Pilih salah satu saja tabel jadwal pemupukan yang diinginkan",
                          style: GoogleFonts.getFont('Poppins',
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(0, 0, 0, containerHeight / 50),
                        child: Text(
                          "Pupuk Tunggal",
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Table(
                        border: TableBorder.all(), // Tambahkan garis
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child: Text(
                                    "Jenis Pupuk",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text(
                                    "Waktu Pemupukan (hst)",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text(
                                  "Takaran Pupuk",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child:
                                      Text('Urea', textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('7', textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child:
                                      Text('100', textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child: Text('SP-36',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('7',style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child:
                                      Text('150', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child:
                                      Text('KCl', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('7', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child:
                                      Text('100', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child:
                                      Text('Urea', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('28-30',
                                      textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child:
                                      Text('150', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child:
                                      Text('Urea', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child:
                                      Text('44', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text(
                                      '150 (jika skala BWD = 4,5)\n100 (jika skala BWD > 4,5)',
                                      textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child:
                                      Text('Urea', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('45-50 (Sesuakan dengan BWD)',
                                      textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('100-150',
                                      textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                            ],
                          ),
                          // Tambahkan baris-baris lain sesuai kebutuhan
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, containerHeight / 50, 0, containerHeight / 50),
                        child: Text(
                          "Pupuk Majemuk\nNPK 15:15:15 (Phonska)",
                          style: GoogleFonts.getFont('Poppins',
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Table(
                          border: TableBorder.all(), // Tambahkan garis
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      "Jenis Pupuk",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      "Waktu Pemupukan (hst)",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                    "Takaran Pupuk",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                    child: Text('Phonska',
                                        textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child:
                                        Text('7', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text('350',
                                        textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                    child: Text('Urea',
                                        textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text('28-30',
                                        textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text('150',
                                        textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                    child: Text('Urea',
                                        textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child:
                                        Text('44', textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                        '150 (jika skala BWD = 4,5)\n100 (jika skala BWD > 4,5)',
                                        textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                    child: Text('Urea',
                                        textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text('45-50 (Sesuakan dengan BWD)',
                                        textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text('100-150',
                                        textAlign: TextAlign.center,style: GoogleFonts.getFont('Poppins')),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(0, containerHeight / 50, 0, 0),
                        child: Text(
                          "Pemupukan Berdasarkan Warna Daun (BWD)",
                          style: GoogleFonts.getFont('Poppins',
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, containerHeight / 50, 0, 0),
                          child: Text(
                              "- BWD hanya digunakan pada waktu pemberian pupuk ketiga.\n- Sebelum pemupukan dilakukan pembacaan BWD dengan cara menempelkan daun jagung teratas yang sudah sempurna terbuka.\n- Waktu pembacaan sebaiknya sore hari agar tidak terpengaruh cahaya matahari.\n- Berikan urea (N) berdasarkan skala BWD pada fase V10-12 (umur 44 hst sebelum pemupukan ketiga)\n- Bila pembacaan skala BWD = 4,5, segera berikan urea 150 kg/ha.\n- Bila skala BWD > 4,5 berikan N (urea) sebanyak 100 kh/ha.",style: GoogleFonts.getFont('Poppins'))),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(0, containerHeight / 50, 0, 0),
                        child: Text(
                          "Catatan: Cara pemberian pupuk: pupuk diletakkan dalam lubang yang dibuat dengan tugal di samping tanaman dengan jarak 5-10 cm dari tanaman dan ditutup dengan tanah/pupuk kandang/pupuk organik.",
                          style: GoogleFonts.getFont('Poppins',
                              fontStyle: FontStyle.italic),
                        ),
                      )
                      // Tambahkan paragraf-paragraf lain sesuai kebutuhan
                    ],
                  ),
                ),
              ),
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
                  'assets/gotan sedekap.png', // Lokasi gambar aset Anda
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
                  'assets/9. gotan-pemupukan.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              ))
        ],
      ),
    );
  }
}
