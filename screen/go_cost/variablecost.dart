import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/screen/go_cost/pendapatan.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VariableCost extends StatefulWidget {
  @override
  _VariableCostState createState() => _VariableCostState();
}

class _VariableCostState extends State<VariableCost> {
  TextEditingController stringInput1Controller = TextEditingController();
  TextEditingController stringInput2Controller = TextEditingController();
  TextEditingController stringInput3Controller = TextEditingController();
  TextEditingController stringInput4Controller = TextEditingController();
  TextEditingController intInput1Controller = TextEditingController();
  TextEditingController intInput2Controller = TextEditingController();
  TextEditingController intInput3Controller = TextEditingController();
  TextEditingController intInput4Controller = TextEditingController();
  TextEditingController resultController = TextEditingController();

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

  void _savevariablecost(int variablecost) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('variablecost', variablecost);
  }

  void _calculateSum() {
    final klik = AudioPlayer();
    klik.setVolume(1.0);
    klik.play(
      AssetSource('click.mp3'),
    );
    int input1 = int.tryParse(intInput1Controller.text) ?? 0;
    int input2 = int.tryParse(intInput2Controller.text) ?? 0;
    int input3 = int.tryParse(intInput3Controller.text) ?? 0;
    int input4 = int.tryParse(intInput4Controller.text) ?? 0;
    int sum1 = input1 + input2 + input3 + input4;
    String formattedSum =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0)
            .format(sum1);
    resultController.text = formattedSum;
    _savevariablecost(sum1);
  }

  Widget inputHarga(
    TextEditingController control,
    String tipe,
    double fieldHeight,
  ) {
    return Container(
      height: fieldHeight,
      child: TextField(
        controller: control,
        decoration: InputDecoration(
          labelText: tipe,
          fillColor: const Color.fromARGB(255, 226, 199, 116),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: GoogleFonts.getFont(
            'Poppins',
            color: Colors.black, // Ganti warna teks label sesuai keinginan Anda
            fontSize: 10,
          ),
        ),
        cursorColor: Colors.black,
      ),
    );
  }

  ButtonStyle kButtonStyle(BuildContext context, double width, double height) {
    double fontSize =
        height * 0.35; // Adjust the percentage as needed for font size
    return ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 210, 149, 81),
      foregroundColor: Colors.black,
      side: BorderSide(color: Color.fromARGB(255, 77, 39, 9), width: 2),
      minimumSize: Size(width, height),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(35.0), // Adjust the radius as needed
      ),
      padding: EdgeInsets.symmetric(horizontal: 20), // Adjust padding as needed
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
    double buttonHeight = screenHeight * 0.12;

    return Scaffold(
        appBar: AppBar(
            title: Text("Total Variable Cost",
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
                  image: image22,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                top: iconSize * 17 / 10,
              right: (buttonHeight * 3)-(iconSize*2),
              left: (buttonHeight * 3)+(iconSize*5/2),
                child: Column(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: containerHeight * 1 / 2,
                          width: containerWidth * 8 / 10,
                          decoration: BoxDecoration(
                            color: const  Color.fromARGB(255, 121, 68,
                                    28), // Warna latar belakang baru
                            border: Border.all(
                              color: Colors.black, // Warna outline
                              width: 2.0, // Lebar outline
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent, // Warna latar belakang baru
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.fromLTRB(iconSize,
                                  iconSize / 2, iconSize, iconSize / 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            inputHarga(stringInput1Controller,
                                                'Produk/Layanan', iconSize),
                                            SizedBox(height: iconSize / 10),
                                            inputHarga(stringInput2Controller,
                                                'Produk/Layanan', iconSize),
                                            SizedBox(height: iconSize / 10),
                                            inputHarga(stringInput3Controller,
                                                'Produk/Layanan', iconSize),
                                            SizedBox(height: iconSize / 10),
                                            inputHarga(stringInput4Controller,
                                                'Produk/Layanan', iconSize),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: iconSize / 4),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            inputHarga(
                                                intInput1Controller,
                                                'Nominal (tanpa titik, spasi, atau mata uang)',
                                                iconSize),
                                            SizedBox(height: iconSize / 10),
                                            inputHarga(
                                                intInput2Controller,
                                                'Nominal (tanpa titik, spasi, atau mata uang)',
                                                iconSize),
                                            SizedBox(height: iconSize / 10),
                                            inputHarga(
                                                intInput3Controller,
                                                'Nominal (tanpa titik, spasi, atau mata uang)',
                                                iconSize),
                                            SizedBox(height: iconSize / 10),
                                            inputHarga(
                                                intInput4Controller,
                                                'Nominal (tanpa titik, spasi, atau mata uang)',
                                                iconSize),
                                          ],
                                        ),
                                      ),
                                    ],
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
                                    onPressed: _calculateSum,
                                    style: kButtonStyle(
                                        context, iconSize * 3 / 2, iconSize),
                                    child: Text('Hitung',
                                        style: GoogleFonts.getFont(
                                          'Poppins',
                                        )),
                                  ),
                                  SizedBox(
                                      width: iconSize /
                                          2), // Jarak antara dua tombol
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
                                              Pendapatan(),
                                        ),
                                      );
                                    },
                                    style: kButtonStyle(
                                        context, iconSize * 3 / 2, iconSize),
                                    child: Text('Lanjut',
                                        style: GoogleFonts.getFont(
                                          'Poppins',
                                        )),
                                  ),
                                ]),
                            SizedBox(height: iconSize / 4),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: iconSize * 5,
                                    height: iconSize,
                                    child: TextField(
                                      controller: resultController,
                                      keyboardType: TextInputType.number,
                                      enabled: false,
                                      style: GoogleFonts.getFont('Poppins',
                                          color: Colors.black),
                                      decoration: const InputDecoration(
                                        labelText: 'Hasilnya di Sini',
                                        fillColor: Color.fromARGB(255, 226, 199,
                                            116), // Warna latar belakang
                                        filled: true,
                                        disabledBorder: OutlineInputBorder(
                                          // Border saat tidak dalam fokus
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ])
                          ],
                        ),
                      ])
                ]))
          ],
        ));
  }
}
