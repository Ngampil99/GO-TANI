import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/screen/infokhusus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Penanaman extends StatefulWidget {
  @override
  _PenanamanState createState() => _PenanamanState();
}

class _PenanamanState extends State<Penanaman> {
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
    double buttonWidth = screenWidth * 0.20; // Adjust the percentage as needed
    return Scaffold(
        appBar: AppBar(
            title: Text("Tahap Penanaman untuk Benih $_infoBenih",
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
                        height: containerHeight * 2 / 3,
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
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Belum memilih benih dan varietas',
                        style: GoogleFonts.getFont('Poppins', fontSize: 18),
                      ),
                    ),
                  );
                }
              } else {
                return const Center(
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
                    _saveinfovariable('penanaman');
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
                  'assets/gotan sedekap.png', // Lokasi gambar aset Anda
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
                  'assets/7. gotan-tanam.png', // Lokasi gambar aset Anda
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
        'a. Penyediaan Bibit',
        '   - Cabut bibit pada umur 16-21 hari. Bibit yang kurang sehat dan kurang vigor tidak digunakan.\n   - Bibit dicabut dengan akar penuh dan batangnya tidak boleh patah.\n   - Bibit diikat, untuk memudahkan pengangkutan distribusi ke petak lahan.\n   - Tidak dianjurkan menanam bibit yang tidak jelas varietasnya, berasal dari penjual bibit siap tanam.',
        'b. Pencaplakan',
        '   - Pencaplakan dilakukan untuk membuat tanda jarak tanam bibit agar seragam dan teratur.\n   - Ukuran caplak menentukan jarak tanam dan populasi rumpun tanaman per satuan luas,\n   - Jumlah rumpun per meter pada berbagai jarak tanam yang dapat dipilih adalah:\n     25 rumpun/m2 = jarak tanam 20 cm x 20 cm\n     16 rumpun/m2 = jarak tanam 25 cm x 25 cm\n     33 rumpun/m2 = jajar legowo 2:1 - 40 cm x (20x10) cm\n     21 rumpun/m2 = jajar legowo 2:1 - 50 cm x (25x12,5) cm\n     40 rumpun/m2 = jajar legowo 4:1 - 40 cm x (20x10) cm\n     26 rumpun/m2 = jajar legowo 4:1 - 50 cm x (25 x 12,5) cm\n   - Pemilihan jaram tergantung kesuburan tanah, varietas, dan dosis pupuk yang digunakan.',
        'c. Penanaman Bibit',
        '   - Bibit asal persemaian sendiri, jika hasil pembelian, harus tahu kondisi varietas dan kesehatan benih.\n   - Bibit padi siap untuk dipetakan.\n   - Pastikan kualitas bibit bagus, sehat, vigorous tidak tercampur gulma.\n   - Saat tanam, air dalam kondisi macak-macak.\n   - Bibit ditanam 1-2 batang/rumpun, varietas hibrida ditanam 1 bibit/rumpun.\n   - Bibit ditanam tegak, leher masuk ke dalam tanah sekitar 1-3 cm.',
        Colors.black,
      );
    } else if (benih == 'jagung') {
      return _buildRichText(
        'Ini Tahapannya',
        '- Penanaman pada perlakuan Tanpa Olah Tanah (TOT) bisa langsung dicangkul pada tempat menugal benih sesuai dengan jarak tanam lalu diberi pupuk kandang atau kompos 1-2 genggam (kurang lebih 50 gram) tiap cangkulan/koakan.\n- Penanaman pada perlakuan Olah Tanah Sempurna (OTS) cukup ditugal untuk dibuat lubang tanam benih sesuai dengan jarak tanam, selanjutnya diberikan pupuk kandang atau kompos 1-2 genggam (kurang lebih 50 gram)\n- Pemberian pupuk kandang dilakukan 3-7 hari sebelum menanam atau bisa juga diberikan pada saat tanam sebagai penutup benih yang baru ditanam.\n- Populasi tanaman jagung yang dianjurkan untuk dipertahankan minimal 66.000 tanaman/ha dengan jarak tanam 75 cm x 20 cm, 1 benih/lubang abu 75 cm x 40 cm 2 benih/lubang\n- Jarak tanam pada musim hujan yang dianjurkan 75 cm x 20 cm dengan 1 benih/lubang pada wilayah yang tenaga kerjanya cukup tersedia. Sedangkan jarak tanam 75 cm x 40 cm dengan 2 benih/lubang dianjurkan untuk diterapkan pada wilayah yang tenaga kerjanya menjadi masalah karena kurang atau mahal.\n- Pada musim kemarau jarak tanam dapat lebih rapat yaitu 70 cm x 20 cm dengan 1 benih per lubang tanam atau 70 cm x 40 cm dengan 2 benih per lubang tanam.\n- Penanaman dengan varietas berumur genjah dapat diperapat lagi yaitu 65 cm x 40 cm dengan 2 benih/lubang.',
        '',
        '',
        '',
        '',
        Colors.black,
      );
    } else if (benih == 'kedelai') {
      return _buildRichText(
        'a. Persiapan',
        '   - Biji atau benih kedelai dapat ditanam secara langsung.\n   - pada umur varietas, varietas yang umur pendek (genjah), sebaiknya menggunakan jarak tanam yang lebih rapat (40 cm x 10 cm), varietas yang umur sedang sebaiknya menggunakan jarak tanam yang sedang (40 cm x 15 cm), dan varietas yang umur dalam (umur panjang), jarak tanam yang digunakan lebih renggang (40 cm x 25 cm).\n   - Karakteristik dari masing-masing varietas dapat dilihat pada menu “Pilih Varietas”',
        'b. Penanaman dan Pemupukan Dasar',
        '   - Penanaman dilakukan dengan tugal dengan jarak tanaman 40 cm x 10 cm atau 40 cm x 15 cm (dua biji per lubang).\n   - Sebelum ditanam, terlebih dahulu diberi pupuk dasar. Pupuk yang digunakan berupa TSP sebanyak 75 kg-200 kg/ha, KCl 50 kg – 100 kg/ha, dan Urea 50 kg/ha.\n   - Agar memperoleh produktivitas yang tinggi, dapat dilakukan cara menanam yang terbaik yaitu dengan membuat lubang tanam memakai tugal dengan kedalaman antara 1,5 – 2 cm.\n   - Setiap lubang tanam diisi sebanyak 3 – 4 biji dan diupayakan 2 biji yang bisa tumbuh.\n   - Penanaman dilakukan dengan memasukkan ke dalam lubang penanaman sebanyak 2 benih/lubang kemudian tabur dengan tanah ',
        'Tips:',
        'Untuk menghindari hama lalat bibit, sebaiknya pada saat penanaman benih diberikan pula Furadan, Curater, atau Indofuran ke dalam lubang tanam.',
        Colors.black,
      );
    } else if (benih == 'kacang tanah') {
      return _buildRichText(
        'Ini Tahapannya',
        '- Pada tanah yang subur jarak tanam 40 cm x 15 cm atau 30 cm x 20 cm, sedangkan pada tanah kurang subur dapat ditanam lebih rapat dengan jarak tanam 40 cm x 10 cm atau 20 cm x 20 cm.\n- Pada bedengan yang telah disiapkan, buatlah lubang tanam dengan kedalaman 3 cm dan tanam benih kacang tanah dengan jarak tanam 40 cm x 20 cm atau 40 x 10 cm dengan jumlah 1-2 benih per lubang tanam.\n- Penanaman juga dapat dilakukan secara baris ganda (50 cm x 30 cm) x 15 cm, satu biji per lubang\n- Penanaman dengan cara ditugal, kedalaman lubang tanam 3-5 cm\n- Kemudian lubang tanam ditutup dengan tanah.\n- Waktu tanam yang paling baik untuk lahan kering adalah pada awal musim hujan.',
        '',
        '',
        '',
        '',
        Colors.black,
      );
    } else {
      return _buildRichText(
        '',
        '',
        '',
        '',
        '',
        '',
        Colors.black,
      );
    }
  }

  Widget _buildRichText(
      String mainText,
      String additionalText2,
      String additionalText3,
      String additionalText4,
      String additionalText5,
      String additionalText6,
      Color textColor) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: mainText,
            style: GoogleFonts.getFont('Poppins',
                fontSize: 14, color: textColor, fontWeight: FontWeight.bold
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
          TextSpan(
            text: additionalText2.isNotEmpty ? '\n$additionalText3' : '',
            style: GoogleFonts.getFont('Poppins',
                fontSize: 14, color: textColor, fontWeight: FontWeight.bold
                // tambahkan style lain yang Anda inginkan di sini
                ),
          ),
          TextSpan(
            text: additionalText2.isNotEmpty ? '\n$additionalText4' : '',
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 14,
              color: textColor,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText2.isNotEmpty ? '\n$additionalText5' : '',
            style: GoogleFonts.getFont('Poppins',
                fontSize: 14, color: textColor, fontWeight: FontWeight.bold
                // tambahkan style lain yang Anda inginkan di sini
                ),
          ),
          TextSpan(
            text: additionalText2.isNotEmpty ? '\n$additionalText6' : '',
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
