import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/screen/menu.dart';
import 'package:go_tani/screen/go_process/panen.dart';
import 'package:go_tani/screen/go_process/pemeliharaan.dart';
import 'package:go_tani/screen/go_process/pemupukan/pemupukanjagung.dart';
import 'package:go_tani/screen/go_process/pemupukan/pemupukankacang.dart';
import 'package:go_tani/screen/go_process/pemupukan/pemupukankedelai.dart';
import 'package:go_tani/screen/go_process/pemupukan/pemupukanpadi.dart';
import 'package:go_tani/screen/go_process/penanaman.dart';
import 'package:go_tani/screen/go_process/persiapan.dart';
import 'package:go_tani/screen/go_process/persiapan_benih/benih.dart';
import 'package:go_tani/services/notification_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pengolahan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GOProcess extends StatefulWidget {
  @override
  _GOProcessState createState() => _GOProcessState();
}

class _GOProcessState extends State<GOProcess> {
  late SharedPreferences prefs;
  bool isButton1Pressed = false;
  bool isButton2Pressed = false;
  bool isButton3Pressed = false;
  bool isButton4Pressed = false;
  bool isButton5Pressed = false;
  bool isButton6Pressed = false;

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
    initPrefs(); // Inisialisasi shared preferences saat widget diinisialisasi
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

  void _saveMulai(String mulai) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('mulai', mulai);
  }

  void _saveMulai2(String mulai2) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('mulai2', mulai2);
  }

  void _savePanen(String panen) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('panen', panen);
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      // Set status tombol sesuai dengan data shared preferences
      isButton1Pressed = prefs.getBool('isButton1Pressed') ?? false;
      isButton2Pressed = prefs.getBool('isButton2Pressed') ?? false;
      isButton3Pressed = prefs.getBool('isButton3Pressed') ?? false;
      isButton4Pressed = prefs.getBool('isButton4Pressed') ?? false;
      isButton5Pressed = prefs.getBool('isButton5Pressed') ?? false;
      isButton6Pressed = prefs.getBool('isButton6Pressed') ?? false;
    });
  }

  Future<void> _loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String varietas = prefs.getString('varietas') ??
        ''; // Mengambil nilai infovar dari Shared Preferences
    String benih = prefs.getString('benih') ??
        ''; // Mengambil nilai infobenih dari Shared Preferences

    // Menentukan rute tombol Persiapan Benih berdasarkan nilai infovar dan infobenih
    String route = (varietas.isEmpty && benih.isEmpty) ||
            (varietas.isEmpty || benih.isEmpty)
        ? 'a'
        : 'b';

    // Menggunakan rute yang telah ditentukan
    if (route == 'a') {
      // Rute ke titik A (misalnya)
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Benih(),
        ),
      );
    } else {
      // Rute ke titik B (misalnya)
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Persiapan(),
        ),
      );
    }
  }

  Future<void> _loadDataFromSharedPreferences3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String benih = prefs.getString('benih') ??
        ''; // Mengambil nilai infobenih dari Shared Preferences
    // Menggunakan if else yang telah ditentukan
    if (benih == 'padi') {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PemupukanPadi(),
        ),
      );
    } else if (benih == 'jagung') {
      Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PemupukanJagung()),
      );
    } else if (benih == 'kacang') {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PemupukanKacang(),
        ),
      );
    } else if (benih == 'kedelai') {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PemupukanKedelai(),
        ),
      );
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MainMenu(),
        ),
      );
    }
  }

  Future<void> _loadDataFromSharedPreferences2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String benih = prefs.getString('benih') ??
        ''; // Mengambil nilai infobenih dari Shared Preferences
    // Menggunakan if else yang telah ditentukan
    if (benih == 'padi') {
      //set jadwal notifikasi dengan mengatur parameter hari
      // NotificationController.scheduleNotificationWithDays(0);
      // NotificationController.scheduleNotificationWithDays(0);
      NotificationController.createNewNotification();
    } else if (benih == 'jagung') {
    } else if (benih == 'kacang tanah') {
    } else if (benih == 'kedelai') {
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MainMenu(),
        ),
      );
    }
  }

  ButtonStyle kOptionStyle(BuildContext context, double width, double height) {
    double fontSize =
        height * 0.3; // Adjust the percentage as needed for font size
    return ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.black, // Change color when button is pressed
        side: const BorderSide(color: Color.fromARGB(255, 77, 39, 9), width: 2),
        fixedSize: Size(width, height),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Adjust the radius as needed
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 0), // Adjust padding as needed
        textStyle: GoogleFonts.getFont('Poppins',
            fontSize: fontSize, fontWeight: FontWeight.w600) // Set font size
        );
  }

  ButtonStyle kCheckStyle(BuildContext context, double height, bool isPressed) {
    return ElevatedButton.styleFrom(
      backgroundColor: isPressed
          ? Colors.green // Change color when button is pressed
          : Color.fromARGB(255, 210, 149, 81),
      side: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2),
      fixedSize: Size(height, height),
      elevation: 0,
      shape: CircleBorder(eccentricity: 0.0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonWidth = screenWidth * 0.20; // Adjust the percentage as needed
    double buttonHeight = screenHeight * 0.12;
    double iconSize = screenHeight * 0.12;

    return Scaffold(
        appBar: AppBar(
            title: const Text(''),
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
                image: image16,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: iconSize,
              right: (buttonHeight * 3)-(iconSize*2),
              left: (buttonHeight * 3)+(iconSize*5/2),
              child: Container(
                  // height:
                  //     ((buttonHeight + 10) * 2) + buttonHeight + (iconSize * 3/2),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 226, 199, 116),
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius:
                  BorderRadius.circular(15.0),),
                  padding: EdgeInsets.all(iconSize / 3),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: !isButton1Pressed
                                          ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                              setState(() {
                                                isButton1Pressed =
                                                    !isButton1Pressed;
                                                prefs.setBool(
                                                    'isButton1Pressed',
                                                    isButton1Pressed);
                                              });
                                            }
                                          : null,
                                      style: kCheckStyle(context, buttonHeight,
                                          isButton1Pressed),
                                      child: isButton1Pressed
                                          ? const Icon(Icons.check,
                                              color: Colors
                                                  .black) // Show check icon when pressed
                                          : null, // No child when not pressed
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed:
                                          !isButton1Pressed // Check if button 1 is pressed
                                              ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                                  _loadDataFromSharedPreferences();
                                                }
                                              : null, // Disable the button if button 1 is not pressed
                                      style: kOptionStyle(
                                          context, buttonWidth, buttonHeight),
                                      child: Text('Persiapan Benih'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16), //
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: !isButton2Pressed
                                          ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                              setState(() {
                                                isButton2Pressed =
                                                    !isButton2Pressed;
                                                prefs.setBool(
                                                    'isButton2Pressed',
                                                    isButton2Pressed);
                                              });
                                            }
                                          : null,
                                      style: kCheckStyle(context, buttonHeight,
                                          isButton2Pressed),
                                      child: isButton2Pressed
                                          ? Icon(Icons.check,
                                              color: Colors
                                                  .black) // Show check icon when pressed
                                          : null, // No child when not pressed
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: !isButton2Pressed
                                          ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      Pengolahan(),
                                                ),
                                              );
                                            }
                                          : null, // Disable the button if button 1 is not pressed
                                      style: kOptionStyle(
                                          context, buttonWidth, buttonHeight),
                                      child: Text('Pengolahan Lahan'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16), // Jarak antara tombol
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: isButton1Pressed &&
                                              isButton2Pressed &&
                                              !isButton3Pressed
                                          ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                              setState(() {
                                                isButton3Pressed =
                                                    !isButton3Pressed;
                                                prefs.setBool(
                                                    'isButton3Pressed',
                                                    isButton3Pressed);
                                              });
                                              _loadDataFromSharedPreferences2();
                                              _saveMulai('mulai');
                                              _saveMulai2('mulai2');
                                            }
                                          : null,
                                      style: kCheckStyle(context, buttonHeight,
                                          isButton3Pressed),
                                      child: isButton3Pressed
                                          ? Icon(Icons.check,
                                              color: Colors
                                                  .black) // Show check icon when pressed
                                          : null, // No child when not pressed
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: isButton1Pressed &&
                                              isButton2Pressed &&
                                              !isButton3Pressed // Check if button 1 is pressed
                                          ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      Penanaman(),
                                                ),
                                              );
                                            }
                                          : null, // Disable the button if button 1 is not pressed
                                      style: kOptionStyle(
                                          context, buttonWidth, buttonHeight),
                                      child: Text('Penanaman'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed:
                                          isButton3Pressed && !isButton4Pressed
                                              ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                                  setState(() {
                                                    isButton4Pressed =
                                                        !isButton4Pressed;
                                                    prefs.setBool(
                                                        'isButton4Pressed',
                                                        isButton4Pressed);
                                                  });
                                                }
                                              : null,
                                      style: kCheckStyle(context, buttonHeight,
                                          isButton4Pressed),
                                      child: isButton4Pressed
                                          ? const Icon(Icons.check,
                                              color: Colors
                                                  .black) // Show check icon when pressed
                                          : null, // No child when not pressed
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: isButton3Pressed &&
                                              !isButton4Pressed // Check if button 1 is pressed
                                          ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                              _loadDataFromSharedPreferences3();
                                            }
                                          : null, // Disable the button if button 1 is not pressed
                                      style: kOptionStyle(
                                          context, buttonWidth, buttonHeight),
                                      child: Text('Pemupukan'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed:
                                          isButton4Pressed && !isButton5Pressed
                                              ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                                  setState(() {
                                                    isButton5Pressed =
                                                        !isButton5Pressed;
                                                    prefs.setBool(
                                                        'isButton5Pressed',
                                                        isButton5Pressed);
                                                  });
                                                }
                                              : null,
                                      style: kCheckStyle(context, buttonHeight,
                                          isButton5Pressed),
                                      child: isButton5Pressed
                                          ? Icon(Icons.check,
                                              color: Colors
                                                  .black) // Show check icon when pressed
                                          : null, // No child when not pressed
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: isButton4Pressed &&
                                              !isButton5Pressed // Check if button 1 is pressed
                                          ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      Pemeliharaan(),
                                                ),
                                              );
                                            }
                                          : null, // Disable the button if button 1 is not pressed
                                      style: kOptionStyle(
                                          context, buttonWidth, buttonHeight),
                                      child: Text('Pemeliharaan'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16), // Jarak antara tombol
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed:
                                          isButton5Pressed && !isButton6Pressed
                                              ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                                  setState(() {
                                                    isButton6Pressed =
                                                        !isButton6Pressed;
                                                    prefs.setBool(
                                                        'isButton6Pressed',
                                                        isButton6Pressed);
                                                  });
                                                  _savePanen('panen');
                                                }
                                              : null,
                                      style: kCheckStyle(context, buttonHeight,
                                          isButton6Pressed),
                                      child: isButton6Pressed
                                          ? Icon(Icons.check,
                                              color: Colors
                                                  .black) // Show check icon when pressed
                                          : null, // No child when not pressed
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: isButton5Pressed &&
                                              !isButton6Pressed // Check if button 1 is pressed
                                          ? () {
                                              final klik = AudioPlayer();
                                              klik.setVolume(1.0);
                                              klik.play(
                                                AssetSource('click.mp3'),
                                              );
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      Panen(),
                                                ),
                                              );
                                            }
                                          : null, // Disable the button if button 1 is not pressed,
                                      style: kOptionStyle(
                                          context, buttonWidth, buttonHeight),
                                      child: Text('Panen'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ]))),
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: buttonWidth, // Lebar Container
                height: buttonWidth, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  'assets/ani sedekap.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              )),
          Positioned(
              right: buttonWidth - (buttonWidth/4),
              bottom: iconSize/6,
              child: Container(
                width: buttonWidth*9/10, // Lebar Container
                height: buttonWidth*9/10, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  'assets/2. ani-goprocess.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              ))
        ]));
  }
}
