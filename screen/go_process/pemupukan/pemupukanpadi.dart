import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/screen/infokhusus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PemupukanPadi extends StatefulWidget {
  @override
  _PemupukanPadiState createState() => _PemupukanPadiState();
}

class _PemupukanPadiState extends State<PemupukanPadi> {
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

  void _saveinfovariable(String variableinfo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('infokhusus', variableinfo);
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
            title: Text('Jadwal dan Dosis Pemupukan', style: GoogleFonts.getFont('Poppins')),
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
                  borderRadius:
                  BorderRadius.circular(15.0),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(containerHeight / 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,0,0,containerHeight/50),
                        child: Text(
                          "*Pilih salah satu saja tabel jadwal pemupukan yang diinginkan",
                          style: GoogleFonts.getFont('Poppins',fontStyle: FontStyle.italic
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,0,0,containerHeight/50),
                        child: Text(
                          "Pemupukan Dasar",
                          style: GoogleFonts.getFont('Poppins',
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
                                    style: GoogleFonts.getFont('Poppins',
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
                                    style: GoogleFonts.getFont('Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text(
                                  "Fase Tanaman",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont('Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text(
                                  "Takaran Pupuk",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont('Poppins',
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
                                  child: Text('Nitrogen (N)',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child:
                                      Text('0-14', textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('Pertumbuhan awal',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('50-100 kg urea/ha',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child: Text('Fosfor (P2O5) dan Sulfur (S)',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('0-14',style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('Pertumbuhan awal',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('100% (seluruhnya)',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child: Text('Kalium (K2O)',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('0-14 HST dan 35-50 HST',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('Pertumbuhan awal dan primordia',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text(
                                      '0-14 HST: 50-100%\n35-50 HST: jika diperlukan tambah 50%',
                                      textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child: Text('Pupuk Majemuk',textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('0-14 dan 21-28',textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('Pertumbuhan awal dan anakan aktif',textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Text('0-14 HST: 100-150 kg/ha\n21-28 HST: 100-150 kg/ha',textAlign: TextAlign.center, style: GoogleFonts.getFont('Poppins')),
                                ),
                              ),
                            ],
                          ),
                          // Tambahkan baris-baris lain sesuai kebutuhan
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,containerHeight/50,0,0),
                        child: Text(
                          "- Pupuk kompos atau bahan organik lainnya yang sudah lapuk diberikan pada waktu menjelang pengolahan tanah atau menjelang tanam.\n- Pada tanah yang subur, pupuk N diberikan dengan dosis sedang (50 kg/ha), pupuk P atau K diberikan seluruhnya. Jika dosis pupuk KCl ≧100 kg/ha, sebagai pupuk dasar L diberikan separuhnya.\n- Jika digunakan pupuk majemuk, dosis pupuk 200-300 kg/ha diaplikasikan pada 14 HST setengahnya dan sisanya pada 35 HST.",
                          style: GoogleFonts.getFont('Poppins',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,containerHeight/50,0,0),
                        child: Text(
                          "Pemupukan Susulan",
                          style: GoogleFonts.getFont('Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,containerHeight/50,0,0),
                        child: Text(
                          "- Diberikan pada fase kritis pertumbuhan tanaman, pada stadia pembentukan anakan aktif (21-28 HST) dan stadia primordia bunga (35-50 HST), tergantung varietas tanaman.\n- Dosis dan waktu pemberian pupuk N susulan didasarkan pada hasil pembacaan Bagan Warna Daun (BWD). Pupuk P dan K didasarkan pada hasil analisis tanah menggunakan Perangkat Uji Tanah Sawah (PUTS).",
                          style: GoogleFonts.getFont('Poppins',
                          ),
                        ),
                      ),
                      // Tambahkan paragraf-paragraf lain sesuai kebutuhan
                    ],
                  ),
                ),
              ),
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
                    _saveinfovariable('pemupukan');
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
