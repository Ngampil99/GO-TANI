import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KelayakanUsaha extends StatefulWidget {
  @override
  _KelayakanUsahaState createState() => _KelayakanUsahaState();
}

class _KelayakanUsahaState extends State<KelayakanUsaha> {

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
    _hitungan();
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

  String _cost = "Tidak ada informasi";
  String _pendapatan = "Tidak ada informasi";
  String _revenue = "Tidak ada informasi";
  String _bcDecimal = "Tidak ada informasi";
  String _rcDecimal = "Tidak ada informasi";
  String _bc = "Tidak ada informasi";
  String _rc = "Tidak ada informasi";

  Future<void> _hitungan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cost = prefs.getString('cost') ?? "Tidak Valid";
    String pendapatan = prefs.getString('pendapatan') ?? "Tidak Valid";
    String revenue = prefs.getString('revenue') ?? "Tidak Valid";
    String bc = prefs.getString('bcDecimal') ?? "Tidak Valid";
    String rc = prefs.getString('rcDecimal') ?? "Tidak Valid";
    String bcRatio = prefs.getString('bcRatio') ?? "Tidak Valid";
    String rcRatio = prefs.getString('rcRatio') ?? "Tidak Valid";
    setState(() {
      _cost = cost;
      _pendapatan = pendapatan;
      _revenue = revenue;
      _bcDecimal = bc;
      _rcDecimal = rc;
      _bc = bcRatio;
      _rc = rcRatio;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth * 90 / 100;
    double containerHeight = screenHeight * 90 / 100;
    double iconSize = screenHeight * 0.12;
    double buttonHeight = screenHeight * 0.12;

    return Scaffold(
      appBar: AppBar(
          title: Text("Uji Kelayakan Usaha", style: GoogleFonts.getFont('Poppins')),
          foregroundColor: Colors.black,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [iconBar1(iconSize,opasiti1),iconBar2(iconSize, opasiti2),iconBar3(iconSize, opasiti3),iconBar4(iconSize, opasiti4)]
        ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image22,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: iconSize * 17 / 10,
              right: (buttonHeight * 3)-(iconSize*2),
              left: (buttonHeight * 3)+(iconSize*5/2),
            child: Container(
              color: Colors.transparent,
              child: Container(
                height: containerHeight * 2 / 3,
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
                          "Simak tabel berikut dan scroll ke bawah untuk cek uji kelayakan usahamu", style: GoogleFonts.getFont('Poppins'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, containerHeight/50),
                        child: Text(
                          "Informasi Umum",
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
                                  child: Padding(padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    "B/C Ratio",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.getFont('Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )),
                              TableCell(
                                child: Center(
                                child: Padding(padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    "R/C Ratio",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.getFont('Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                child: Padding(padding: EdgeInsets.all(5.0),
                                  child:
                                      Text('- Perbandingan antara keuntungan dan biaya usaha\n- Jika B/C Ratio > 0, usaha tani menguntungkan\n- Jika B/C Ratio > 0, usaha tani mendapat kerugian', textAlign: TextAlign.left, style: GoogleFonts.getFont('Poppins')),
                                ),
                              )),
                              TableCell(
                                child: Center(
                                child: Padding(padding: EdgeInsets.all(5.0),
                                  child: Text('- Perbandingan antara pendapatan dan biaya usaha\n- Jika R/C Ratio > 1, usaha tani layak dikembangkan\n- Jika R/C Ratio > 1, usaha tani tidak layak dikembangkan', textAlign: TextAlign.left, style: GoogleFonts.getFont('Poppins')),
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,containerHeight/50,0,0),
                        child: Text(
                          "*Jika usaha tidak menghasilkan keuntungan atau kerugian maka dianggap mencapai kondisi BEP (Break Event Point)",
                          style: GoogleFonts.getFont('Poppins',fontStyle: FontStyle.italic
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, containerHeight/50, 0, containerHeight/50),
                        child: Text(
                          "Uji Kelayakan Usaha",
                          style: GoogleFonts.getFont('Poppins',
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,0,0,containerHeight/50),
                        child: Text(
                          "Berdasarkan penghitungan sebelumnya total pengeluaran adalah $_cost, total pendapatan adalah $_pendapatan, dan total keuntungan adalah $_revenue", style: GoogleFonts.getFont('Poppins')),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,0,0,containerHeight/50),
                        child: Text("Mari kita hitung B/C Ratio dengan cara membagi B (Benefit) dengan C (Cost)\n$_revenue / $_cost = $_bcDecimal\nHasil ini menunjukkan bahwa usaha tani $_bc.", style: GoogleFonts.getFont('Poppins'))
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,0,0,containerHeight/50),
                        child: Text("Sekarang kita hitung R/C Ratio dengan cara membagi R (Revenue) dengan C (Cost)\n$_pendapatan / $_cost = $_rcDecimal\nHasil ini menunjukkan bahwa usaha tani $_rc.", style: GoogleFonts.getFont('Poppins'))
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
