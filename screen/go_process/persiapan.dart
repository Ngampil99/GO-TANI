import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class Persiapan extends StatefulWidget {
  @override
  _PersiapanState createState() => _PersiapanState();
}

class _PersiapanState extends State<Persiapan> {
  String _infoBenih = '';
  double opasiti1 = 1;
  double opasiti2 = 1;
  double opasiti3 = 1;
  double opasiti4 = 1;
  double latestPhValue = 0;
  double latestKelembapanValue = 0;
  double latestKetinggianValue = 0;
  double latestSuhuValue = 0;
  String imageMaskot = '';
  String imageDialog = '';

  @override
  void initState() {
    super.initState();
    _getInfoBenih();
    getDataSensor();
    getLokasiGambar();
  }

  Future<void> getLokasiGambar() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String info = prefs.getString('benih') ?? '';

      if (info == 'padi') {
        setState(() {
        imageMaskot = 'assets/gotan sedekap.png';
      });
      setState(() {
        imageDialog = 'assets/5.1 gotan-persiapan benih padi.png';
      });
      } else if(info == 'jagung') {
        setState(() {
        imageMaskot = 'assets/gotan sedekap.png';
      });
      setState(() {
        imageDialog = 'assets/5.2 gotan-persiapan benih jagung.png';
      });
      } else if(info == 'kacang tanah') {
        setState(() {
        imageMaskot = 'assets/gotan sedekap.png';
      });
      setState(() {
        imageDialog = 'assets/5.3 gotan-persiapan benih kacang.png';
      });
      } else if(info == 'kedelai') {
        setState(() {
        imageMaskot = 'assets/gotan sedekap.png';
      });
      setState(() {
        imageDialog = 'assets/5.4 gotan-persiapan benih kedelai.png';
      });
      }else {
        setState(() {
        imageMaskot = '';
      });
      setState(() {
        imageDialog = '';
      });
      }
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String info = prefs.getString('benih') ?? '';
      setState(() {
        _infoBenih = info;
      });
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
            title: Text("Tahap Persiapan Benih $_infoBenih", style: GoogleFonts.getFont('Poppins')),
            foregroundColor: Colors.black,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [iconBar1(iconSize,opasiti1),iconBar2(iconSize, opasiti2),iconBar3(iconSize, opasiti3),iconBar4(iconSize, opasiti4)]),
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
                      borderRadius:
                  BorderRadius.circular(15.0),
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
                        style: GoogleFonts.getFont('Poppins',fontSize: 18),
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
              right: 0,
              bottom: 0,
              child: Container(
                width: buttonWidth, // Lebar Container
                height: buttonWidth, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  imageMaskot, // Lokasi gambar aset Anda
                  fit: BoxFit.contain, // Mode tampilan gambar (opsional)
                ),
              )),
          Positioned(
              right: buttonWidth*3/4,
              bottom: 0,
              child: Container(
                width: buttonWidth, // Lebar Container
                height: buttonWidth, // Tinggi Container
                color: Colors.transparent, // Warna Container (opsional)
                child: Image.asset(
                  imageDialog, // Lokasi gambar aset Anda
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
        '   a. Pemilihan Varietas',
        '      - Dianjurkan memilih varietas unggul, adaptif lingkungan spesifik, dan tahan OPT utama yang terdapat di lokasi.\n      - Umur panen disesuaikan dengan pola tanam atau ketersediaan air.\n      - Disarankan memilih varietas secara rotasi antar musim.\n',
        '   b. Pemilihan Benih',
        '      - Disarankan memilih benih dengan berat jenis tinggi, mutu fisiologis (daya kecambah dan vigor) tinggi, mampu memberikan pertumbuhan cepat dan seragam.\n      - Benih murni, bernas, bersih, sehat, dan sebaiknya berlabel.\n      - Masa dormansi benih telah terlewati.\n',
        '   c. Pematahan Dormansi',
        '      Untuk mengatasi dormansi dapat dilakukan dengan beberapa cara, yaitu:\n      - Pemanasan benih dalam oven suhu 50C selama 2-3 hari.\n      - Pemanasan dalam oven suhu 50C selama 2 hari, dilanjutkan perendaman benih dalam air selama 2 hari.\n      - Pemanasan dalam oven pada suhu 50C selama 2 hari, dilanjutkan perendaman menggunakan larutan 3% KNO3 murni selama 2 hari.\n      - Perendaman dalam larutan pupuk KNO3 putih (3%) atau pupuk KNO3 merah (30 gram KNO3 dalam 1 liter air) selama 1-2 hari.\n',
        '   d. Penentuan Benih Bernas',
        '      Menggunakan air:',
        '      - Benih dimasukkan ke dalam wadah yang berisi air, volume air 2 kali volume benih, lalu diaduk.\n      - Pisahkan benih yang terapung dan benih yang tenggelam,\n      - Benih yang tenggelam berarti bernah, baik untuk pesemaian.\n      - Sebelum disemai, benih direndam selama 24 jam dan diperam satu malam.',
        '      Menggunakan Larutan Pupuk ZA',
        '      - Konsentrasi larutan pupuk ZA 225 gram ZA/liter air. Volume larutan tergantung jumlah benih yang akan dipaka untuk pesemaian.\n      - Benih terapung dibuang, pisahkan dengan benih yang tenggelam.\n      - Benih dicuci bersih, direndam 24 jam, diperam satu malam dan siap untuk ditabur/disemai.\n',
        '   e. Persemaian',
        '      - Lahan untuk penyemaian aman dari gangguan binatang, mudah dialiri air, tidak dekat lampu.\n      - Gunakan pupuk kandang matang, tabur rata 3-4 kg/m3 sebelum olah tanah\n      - Olah tanah sampai halus/gembur, bebas gulma, sisa gulma, dan tanaman.\n      - Luas pesemaian 50 m2 untuk tanam seluas 10 are (500 m2/ha)\n      - Buat bedengan dengan lebar 1,5 meter dan panjang menyesuaikan kebutuhan.\n      - Aplikasikan pestisida 15 hari sebelum tabur (sesuaikan dengan kondisi lapangan). (masih dicari opsi pertanian organik).\n      - Benih yang telah direndam dan di peran ditabur merata.\n      - Aplikasikan pupuk 4 kg urea + 3 kg SP36 + 2 kg KCl per 100 m2 dan tebar merata sebelum benih berkecambah.\n      - Saat benih berkecambah, beri tambahan air, ketinggian air sampai pangkal batang. Air dipertahankan selama persemaian.\n      - Pesemaian dipagar plastik setinggi 70 cm di sekeliling untuk melindungi dari serangga, tikus, ayam, dan sebagainya.\n      - Tanaman pesemaian dipantau 2-3 hari sekali, mewaspadai hama wereng, penggerek batang, atau hama lain.\n      - Apabila terdapat hama, dikendalikan dengan pestisida. (masih dicari opsi pertanian organik)\n      - Bibit yang telah disemai akan siap ditanam pada umur 16-25 HST (hari setelah tabur).',
        Colors.black,
      );
    } else if (benih == 'jagung') {
      return _buildRichText(
        'Begini Persiapannya',
        'Benih jagung dapat diperoleh langsung dari penjual benih maupun dapat dibuat sendiri.\n- Perlakukan benih yang dibuat sendiri: diberi perlakuan dengan metalaksil (umumnya berwarna merah) sebanyak 2 gram (bahan produk) per 1 kg benih yang dicampur dengan 10 ml air. Larutan tersebut dicampur merata pada benih sebelum ditanam untuk mencegah serangan penyakit bulai, yang merupakan penyakit utama pada jagung.\n- Untuk benih jagung yang langsung dibeli dari penjual benih tidak perlu diberi perlakuan benih dan bisa langsung ditanam.',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        Colors.black,
      );
    } else if (benih == 'kedelai') {
      return _buildRichText(
        'Tidak ada tips tertentu',
        'Pada dasarnya biji atau benih kedelai dapat ditanam secara langsung. Jadi langsung saja pergi ke menu Pengolahan Lahan untuk memulai tahap selanjutnya',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        Colors.black,
      );
    } else if (benih == 'kacang tanah') {
      return _buildRichText(
        'Tidak ada tips tertentu',
        'Pada dasarnya biji atau benih kacang tanah dapat ditanam secara langsung. Jadi langsung saja pergi ke menu Pengolahan Lahan untuk memulai tahap selanjutnya',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        Colors.black,
      );
    } else {
      return _buildRichText(
        'Belum ada informasi persiapan untuk benih ini',
        '',
        '',
        '',
        '',
        '',
        '',
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
      String additionalText7,
      String additionalText8,
      String additionalText9,
      String additionalText10,
      String additionalText11,
      String additionalText12,
      String additionalText13,
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
            style: GoogleFonts.getFont('Poppins',
              fontSize: 14,
              color: textColor,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText3.isNotEmpty ? '\n$additionalText3' : '',
            style: GoogleFonts.getFont('Poppins',
                fontSize: 14, color: textColor, fontWeight: FontWeight.bold
                // tambahkan style lain yang Anda inginkan di sini
                ),
          ),
          TextSpan(
            text: additionalText4.isNotEmpty ? '\n$additionalText4' : '',
            style: GoogleFonts.getFont('Poppins',
              fontSize: 14,
              color: textColor,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText5.isNotEmpty ? '\n$additionalText5' : '',
            style: GoogleFonts.getFont('Poppins',
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.bold,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText6.isNotEmpty ? '\n$additionalText6' : '',
            style: GoogleFonts.getFont('Poppins',
              fontSize: 14,
              color: textColor,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText7.isNotEmpty ? '\n$additionalText7' : '',
            style: GoogleFonts.getFont('Poppins',
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.bold,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText8.isNotEmpty ? '\n$additionalText8' : '',
            style: GoogleFonts.getFont('Poppins',
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.bold,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText9.isNotEmpty ? '\n$additionalText9' : '',
            style: GoogleFonts.getFont('Poppins',
              fontSize: 14,
              color: textColor,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText10.isNotEmpty ? '\n$additionalText10' : '',
            style: GoogleFonts.getFont('Poppins',
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.bold,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText11.isNotEmpty ? '\n$additionalText11' : '',
            style: GoogleFonts.getFont('Poppins',
              fontSize: 14,
              color: textColor,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText12.isNotEmpty ? '\n$additionalText12' : '',
            style: GoogleFonts.getFont('Poppins',
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.bold,
              // tambahkan style lain yang Anda inginkan di sini
            ),
          ),
          TextSpan(
            text: additionalText13.isNotEmpty ? '\n$additionalText13' : '',
            style: GoogleFonts.getFont('Poppins',
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
