import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/screen/infokhusus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';

class Pengolahan extends StatefulWidget {
  @override
  _PengolahanState createState() => _PengolahanState();
}

class _PengolahanState extends State<Pengolahan> {
  String _infoBenih = '';
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
    _getInfoBenih();
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

  Future<void> _getInfoBenih() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String info = prefs.getString('benih') ?? '';
      print("Nilai dari Shared Preferences: $info");
      setState(() {
        _infoBenih = info;
      });
    } catch (e) {
      print("Error saat mengambil data dari Shared Preferences: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth * 90 / 100;
    double containerHeight = screenHeight * 90 / 100;
    double iconSize = screenHeight * 0.12;
    double buttonWidth = screenWidth * 0.20; // Adjust the percentage as needed
    return Scaffold(
        appBar: AppBar(
            title: Text("", style: GoogleFonts.getFont('Poppins')),
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
          FutureBuilder(
            future: getPenjelasan(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Positioned(
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
                        padding: EdgeInsets.all(0),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(15),
                          child: snapshot.data as Widget,
                        ),
                      )));
                } else {
                  return Center(
                    child: Container(
                      color: Colors.amber,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Belum memilih benih dan varietas',
                        style: GoogleFonts.getFont('Poppins', fontSize: 18),
                      ),
                    ),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
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
                    _saveinfovariable('pengolahan lahan');
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
                width: buttonWidth, // Lebar Container
                height: buttonWidth, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  'assets/ani sedekap.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              )),
          Positioned(
              right: buttonWidth * 3 / 4,
              bottom: 0,
              child: Container(
                width: buttonWidth, // Lebar Container
                height: buttonWidth, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  'assets/6. ani-pengolahan tanah.png', // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              ))
        ]));
  }

  Future<Widget?> getPenjelasan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? benih = pref.getString('benih');

    if (benih == 'padi') {
      return _buildRichText(
        '  - Sebelum olah tanah, ditaburkan merata pupuk kompos atau pupuk kandang 1-5 ton/han.\n  - Air digenangkan setinggi 2-5 cm di atas permukaan selama 2-5 hari sebelum pembajakan.\n  - Pembajakan tanah I: sedalam 15-20 cm menggunakan bajak traktor singkal, lalu tanah diistirahatkan (inkubasi ) selama 3-4 hari.\n  - Lakukan perbaikan pematang sawah dengan cara “mopok”. Pematang dibuat cukup besar dan pastikan air tidak rembes.\n  - Pojok petakan dan sekitar pematang yang tidak terbajak, dicangkul sedalam 20 cm.\n  - Genang lahan selama 2-3 hari, sedalam 2-5 cm di atas permukaan.\n  - Pembajakan tanah II: untuk pelumpuran tanah, rumput dibenam dan tanah dijadikan lumpur.\n  - Permukaan tanah diratakan dengan cangkul garu. Sisa gulma dibuang atau disingkirkan.\n  - Lahan yang telah diolah, diistirahatkan 1-2 hari, supaya lumpur stabil.\n  - Jika diperlukan, dapat diberi herbisida pratumbuh, diaplikasikan setelah pengolahan tanah selesai pada kondisi air macak-macak.',
        '',
        Colors.black,
      );
    } else if (benih == 'jagung') {
      return _buildRichText(
        '  - Pengolahan tanah untuk penanaman jagung dapat dilakukan dengan 2 cara, yaitu Olah Tanah Sempurna (OTS) jika tanah berkadar liat tinggi, dan Tanpa Olah Tanah (TOT) jika lahan sudah gembur.\n  - Pada lahan yang ditanami jagung dua kali setahun, penanaman pada musim penghujan tanah diolah dengan OTS dan pada musim tanam berikutnya (musim gadu) penanaman dilakukan TOT untuk mempercepat waktu tanam.\n  - Selanjutnya dilakukan penataan lahan dan pembuatan saluran/drainase.\n  - Jika pH tanah kurang dari 5, sebaiknya ditambah kapur dengan dosis 300 kg/ha.',
        '',
        Colors.black,
      );
    } else if (benih == 'kedelai') {
      return _buildRichText(
        '  - Tanah bekas penanaman padi tidak perlu diolah (Tanpa Olah Tanah = TOT), tetapi jerami padi perlu dipotong pendek untuk memberantas gulma perlu disemprot dengan herbisida kontak atau sistemik.\n  - Pertama, jerami padi yang tersisa dibersihkan, kemudian dikumpulkan, dan dibiarkan mengering. Jika areal penanaman kedelai yang digunakan berupa lahan kering atau tegalan, sebaiknya dilakukan pengolahan tanah terlebih dahulu.\n  - Tanah dicangkul atau dibajak sedalam 15-20 cm. Jika lahan yang digunakan termasuk tanah asam dengan pH < 5, bersamaan dengan pengolahan tanah dilakukan pengapuran. Dosis pengapuran disesuaikan dengan pH lahan.\n  - Pengapuran menggunakan dolomite dilakukan dengan cara menyebar rata dengan dosis 1,5 ton/ha. Jika ditambah pupuk kandang 2 - 4 ton/ha, maka dosis kapur dapat dikurangi menjadi 750 kg/ha.\n  - Lahan kering masam sebaiknya menggunakan kapur pertanian (dolomit atau kalsit) dengan dosis : - pH 4,8 - 5,3 -> 2,0 t/ha. - pH 5,3 - 5,5 -> 1,0 t/ha. - pH 5,5 - 6,0 -> 0,5 t/ha.',
        '',
        Colors.black,
      );
    } else if (benih == 'kacang tanah') {
      return _buildRichText(
        '  - Tanah yang cocok untuk tanaman kacang tanah adalah jenis tanah yang gembur/bertekstur ringan dan subur.\n  - Untuk tanah yang kurang subur pada saat pengolahan tanah dapat mencampurkan pupuk kandang atau pupuk kompos untuk menyuburkan tanah. \n  - Dilakukan pembukaan lahan: Pembersihan lahan dari segala macam gulma (tumbuhan pengganggu) dan akar-akar pertanaman sebelumnya. Tujuannnya adalah agar memudahkan perakaran tanaman berkembang dan menghilangkan tumbuhan inang bagi hama dan penyakit yang mungkin ada\n  - Sebelum menanam kacang tanah, dilakukan proses penggemburan tanah dengan cara dicangkul atau dibajak.\n  - Tanah dibajak 2 kali sedalam 15-20 cm, lalu digaru, dan diratakan, kemudian dibersihkan dari sisa tanaman dan gulma.\n  - Saat musim hujan, jika lahan mudah tergenang, buatlah saluran drainase yang baik atau buat bedengan dengan lebar 80-100 cm dan tinggi sekitar 20-30 cm agar drainase lancar.\n  - Berikan dolomit atau kapur pertanian sebanyak 1-2 ton per hektar dengan cara menaburkan tipis di atas tanah dan diamkan selama 5 hari. Hal ini dilakukan untuk meminimalisasi terjadinya keasaman tanah yang mengakibatkan daun kacang kurang sehat (kuning).',
        '',
        Colors.black,
      );
    } else {
      return _buildRichText(
        '',
        '',
        Colors.black,
      );
    }
  }

  Widget _buildRichText(
      String mainText, String additionalText2, Color textColor) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: mainText,
            style: GoogleFonts.getFont('Poppins', fontSize: 14, color: textColor
                // tambahkan style lain yang Anda inginkan di sini
                ),
          ),
          TextSpan(
            text: additionalText2.isNotEmpty ? '\n$additionalText2' : '',
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 14,
              color: textColor,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}
