import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoBenih extends StatefulWidget {
  @override
  _InfoBenihState createState() => _InfoBenihState();
}

class _InfoBenihState extends State<InfoBenih> {
  late List<List<CellData>> tableData;
  String cell7Text = '';
  String cell8Text = '';
  String cell9Text = '';
  String cell10Text = '';
  String cell11Text = '';
  String cell12Text = '';
  String cell13Text = '';
  String cell14Text = '';
  String cell15Text = '';
  String cell16Text = '';
  String cell17Text = '';
  String cell18Text = '';
  String cell19Text = '';
  String cell20Text = '';
  String cell21Text = '';
  String cell22Text = '';
  String cell23Text = '';
  String cell24Text = '';
  String cell25Text = '';
  String cell26Text = '';
  String cell27Text = '';
  String cell28Text = '';
  String cell29Text = '';
  String cell30Text = '';
  String cell31Text = '';
  String cell32Text = '';
  String cell33Text = '';
  String cell34Text = '';
  bool isDataLoaded = false;

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
    _loadDataFromSharedPreferences();
    _getInfoBenih();
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

  Future<void> _loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String infobenih = prefs.getString('infobenih') ?? '';

    if (infobenih == 'Padi') {
      cell7Text = '24-29';
      cell8Text = '22-24\n29-32';
      cell9Text = '18-22\n32-35';
      cell10Text = '<18\n>35';

      cell11Text = '33-90';
      cell12Text = '30-33';
      cell13Text = '<30\n>90';
      cell14Text = '-';

      cell15Text = '5,5-7,0';
      cell16Text = '4,5-5,5\n7,0-8,0';
      cell17Text = '<4,5\n>8,0';
      cell18Text = '-';

      cell19Text = 'sedang';
      cell20Text = 'rendah';
      cell21Text = 'sangat rendah';
      cell22Text = '-';

      cell23Text = 'tinggi';
      cell24Text = 'sedang';
      cell25Text = 'rendah-sangat rendah';
      cell26Text = '-';

      cell27Text = 'sedang';
      cell28Text = 'rendah';
      cell29Text = 'sangat rendah';
      cell30Text = '-';

      cell31Text = 'tinggi: 25 cm\nlama: tanpa';
      cell32Text = 'tinggi: 25-50 cm\nlama: <7 hari';
      cell33Text = 'tinggi: 50-75 cm\nlama: 7-14 hari';
      cell34Text = '>75\n>14';

      // Jika klik info benih jagung
    } else if (infobenih == 'Jagung') {
      cell7Text = '20-26';
      cell8Text = '26-30';
      cell9Text = '16 - 20\n30 - 32';
      cell10Text = '< 16\n> 32';

      cell11Text = '>42';
      cell12Text = '36-42';
      cell13Text = '30-36';
      cell14Text = '<30';

      cell15Text = '5,8-7,8';
      cell16Text = '5,5-5,8\n7,8-8,2';
      cell17Text = '<5,5\n>8,2';
      cell18Text = '-';

      cell19Text = 'sedang';
      cell20Text = 'rendah';
      cell21Text = 'sangat rendah';
      cell22Text = '-';

      cell23Text = 'tinggi';
      cell24Text = 'sedang';
      cell25Text = 'rendah-sangat rendah';
      cell26Text = '-';

      cell27Text = 'sedang';
      cell28Text = 'rendah';
      cell29Text = 'sangat rendah';
      cell30Text = '-';

      cell31Text = 'tinggi: -\nlama: -';
      cell32Text = 'tinggi: -\nlama: -';
      cell33Text = 'tinggi: 25 cm\nlama<7 hari';
      cell34Text = '>25 cm\n>7 hari';
    } else if (infobenih == 'Kedelai') {
      cell7Text = '25-27';
      cell8Text = '20-24\n80-85';
      cell9Text = '<20\n>85';
      cell10Text = '-';

      cell11Text = '24-80';
      cell12Text = '>80\n<50';
      cell13Text = '>80\n<50';
      cell14Text = '-';

      cell15Text = '5,5-7,5';
      cell16Text = '5,0-5,5\n7,5-7,8';
      cell17Text = '<5,0\n>7,8';
      cell18Text = '-';

      cell19Text = 'sedang';
      cell20Text = 'rendah';
      cell21Text = 'sangat rendah';
      cell22Text = '-';

      cell23Text = 'tinggi';
      cell24Text = 'sedang';
      cell25Text = 'rendah-sangat rendah';
      cell26Text = '-';

      cell27Text = 'sedang';
      cell28Text = 'rendah';
      cell29Text = 'sangat rendah';
      cell30Text = '-';

      cell31Text = 'tinggi: -\nlama: -';
      cell32Text = 'tinggi: -\nlama: -';
      cell33Text = 'tinggi: 25 cm\nlama: <7 hari';
      cell34Text = '>25 cm\n>=7 hari';
    } else if (infobenih == 'Kacang Tanah') {
      cell7Text = '25-27';
      cell8Text = '20-25\n27-30';
      cell9Text = '18-20\n30-34';
      cell10Text = '<18\n>34';

      cell11Text = '50-80';
      cell12Text = '>80\n<50';
      cell13Text = '>80\n<50';
      cell14Text = '-';

      cell15Text = '6,0-7,0';
      cell16Text = '5,0-6,0\n7,0-7,5';
      cell17Text = '<5,0\n>7,5';
      cell18Text = '-';

      cell19Text = 'sedang';
      cell20Text = 'rendah';
      cell21Text = 'sangat rendah';
      cell22Text = '-';

      cell23Text = 'tinggi';
      cell24Text = 'sedang';
      cell25Text = 'rendah-sangat rendah';
      cell26Text = '-';

      cell27Text = 'sedang';
      cell28Text = 'rendah';
      cell29Text = 'sangat rendah';
      cell30Text = '-';

      cell31Text = 'tinggi: -\nlama: -';
      cell32Text = 'tinggi: -\nlama: -';
      cell33Text = 'tinggi: 25 cm\nlama: <7 hari';
      cell34Text = '>25 cm\n>7 hari';
    } else {
      // Jika tidak ada data yang cocok dalam SharedPreferences
      cell7Text = 'Data tidak valid';
      cell8Text = 'Data tidak valid';
      cell9Text = 'Data tidak valid';
      cell10Text = 'Data tidak valid';

      cell11Text = 'Data tidak valid';
      cell12Text = 'Data tidak valid';
      cell13Text = 'Data tidak valid';
      cell14Text = 'Data tidak valid';

      cell15Text = 'Data tidak valid';
      cell16Text = 'Data tidak valid';
      cell17Text = 'Data tidak valid';
      cell18Text = 'Data tidak valid';

      cell19Text = 'Data tidak valid';
      cell20Text = 'Data tidak valid';
      cell21Text = 'Data tidak valid';
      cell22Text = 'Data tidak valid';

      cell23Text = 'Data tidak valid';
      cell24Text = 'Data tidak valid';
      cell25Text = 'Data tidak valid';
      cell26Text = 'Data tidak valid';

      cell27Text = 'Data tidak valid';
      cell28Text = 'Data tidak valid';
      cell29Text = 'Data tidak valid';
      cell30Text = 'Data tidak valid';

      cell31Text = 'Data tidak valid';
      cell32Text = 'Data tidak valid';
      cell33Text = 'Data tidak valid';
      cell34Text = 'Data tidak valid';
    }

    setState(() {
      tableData = [
        // ...
        [
          CellData(
              'Parameter',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
          CellData(
              'S1',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
          CellData(
              'S2',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
          CellData(
              'S3',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
          CellData(
              'N',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
        ],
        [
          CellData(
              'Temperatur (C)',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell7Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell8Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell9Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell10Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
        [
          CellData(
              'Kelembaban (%)',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell11Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell12Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell13Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell14Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
        [
          CellData(
              'pH H2O',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell15Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell16Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell17Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell18Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
        [
          CellData(
              'Nitrogen (N)',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell19Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell20Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell21Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell22Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
        [
          CellData(
              'P2O5 (mg/100g)',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell23Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell24Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell25Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell26Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
        [
          CellData(
              'K2O (mg/100 g)',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell27Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell28Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell29Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell30Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
        [
          CellData(
              'Bahaya banjir/genangan pada masa tanam',
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell31Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell32Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell33Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell34Text,
              GoogleFonts.getFont('Poppins',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
        // Add more rows with different text styles as needed
      ];

      isDataLoaded =
          true; // Setelah data diinisialisasi, ubah nilai isDataLoaded menjadi true
    });
  }

  String _infoBenih = "Tidak ada informasi benih";
  Future<void> _getInfoBenih() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String info = prefs.getString('infobenih') ?? "Tidak Valid";
    setState(() {
      _infoBenih = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoaded
        ? _buildTable() // Jika data sudah diinisialisasi, tampilkan tabel
        : const Center(
            child:
                CircularProgressIndicator()); // Jika belum, tampilkan loading
  }

  Widget _buildTable() {
    double screenWidth = MediaQuery.of(context).size.width;
    double tableWidth = screenWidth *
        0.65; // Set the desired width for the table (80% of the screen width)
    double columnWidth = tableWidth / tableData[0].length;
    double screenHeight = MediaQuery.of(context).size.height;
    double iconSize = screenHeight * 0.12;

    return Scaffold(
        appBar: AppBar(
            title: Text("Informasi Benih $_infoBenih",
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
            // Latar belakang baru di atas background body dengan outline
            Positioned(
              top: iconSize *
                  17 /
                  10, // Posisi atas (sesuaikan dengan kebutuhan)
              bottom: 50, // Posisi bawah (sesuaikan dengan kebutuhan)
              left: 85, // Posisi kiri (sesuaikan dengan kebutuhan)
              right: 85, // Posisi kanan (sesuaikan dengan kebutuhan)
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 226, 199, 116,
                      ), // Warna latar belakang baru
                  border: Border.all(
                    color: Colors.black, // Warna outline
                    width: 2.0, // Lebar outline
                  ),
                  borderRadius:
                  BorderRadius.circular(15.0),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (screenWidth - tableWidth) / 6,
                      vertical: (screenWidth - tableWidth) / 8,
                    ),
                    child: Container(
                      width: tableWidth,
                      child: Table(
                        border:
                            TableBorder.all(width: 1.0, color: Colors.black),
                        defaultColumnWidth: FixedColumnWidth(columnWidth),
                        children: _buildRows(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Teks di bawah tabel (di luar kontainer yang di-scroll)
            Positioned(
              bottom: 10, // Posisi bawah (sesuaikan dengan kebutuhan)
              left: 85, // Posisi kiri (sesuaikan dengan kebutuhan)
              right: 40, // Posisi kanan (sesuaikan dengan kebutuhan)
              child: Container(
                child: Text(
                  '*S1: sangat sesuai; S2: cukup sesuai; S3: sesuai marginal; N: tidak sesuai;\n(-) tidak diperhitungkan',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontSize: 12, // Ukuran teks (sesuaikan dengan kebutuhan)
                    color: Colors.white, // Warna teks
                    shadows: [
                      const Shadow(
                        blurRadius: 1.0, // Radius bayangan
                        color: Colors.black, // Warna bayangan
                        offset: Offset(0.0, 2.0), // Posisi bayangan (x, y)
                      ),
                    ],
                    fontWeight: FontWeight
                        .w400, // Ketebalan teks (sesuaikan dengan kebutuhan)
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ));
  }

  List<TableRow> _buildRows(BuildContext context) {
    List<TableRow> rows = [];
    for (int i = 0; i < tableData.length; i++) {
      List<Widget> rowChildren = [];
      for (int j = 0; j < tableData[i].length; j++) {
        if (i == 0) {
          // Mengatur alignment untuk setiap baris pertama
          rowChildren.add(
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0), // Tambahkan jarak di sini
                child: Text(
                  tableData[i][j].text,
                  style: GoogleFonts.getFont('Poppins',
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else if (j == 0) {
          // Mengatur alignment untuk setiap kolom pertama
          rowChildren.add(
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0), // Tambahkan jarak di sini
                child: Text(
                  tableData[i][j].text,
                  style: GoogleFonts.getFont('Poppins',
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else {
          // Mengatur alignment untuk sel lainnya
          rowChildren.add(
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8.0), // Tambahkan jarak di sini
                child: Text(
                  tableData[i][j].text,
                  style: GoogleFonts.getFont('Poppins',
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          );
        }
      }
      rows.add(
        TableRow(
          children: rowChildren,
        ),
      );
    }
    return rows;
  }
}

class CellData {
  final String text;
  final TextStyle style;

  CellData(this.text, this.style);
}
