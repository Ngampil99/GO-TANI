import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoVar extends StatefulWidget {
  @override
  _InfoVarState createState() => _InfoVarState();
}

class _InfoVarState extends State<InfoVar> {
  late List<List<CellData>> tableData;
  String cell7Text = '';
  String cell8Text = '';
  String cell9Text = '';
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
    _getInfoVar();
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
    String infovar= prefs.getString('infovar') ?? '';

    // Tambahkan kondisi if else sesuai kebutuhan
    if (infovar == 'Jagung Lamuru') {
      cell7Text = 'Lamuru';
      cell8Text = '7,6';
      cell9Text = 'Agak toleran dengan penyakit bulai, tahan kekeringan, umur panen 95 hari';
    
    } else if (infovar == 'Jagung Sukmaraga') {
      cell7Text = 'Sukmaraga';
      cell8Text = '10,5';
      cell9Text = 'Toleran dengan penyakit bulai, tahan kemasaman, umur panen 105 hari';
    
    } else if (infovar == ' Jagung Srikandi Kuning') {
      cell7Text = 'Srikandi Kuning';
      cell8Text = '7,9';
      cell9Text = 'Protein bermutu. Kurang tahan penyakit bulai. Umur panen 110 hari.';
    
    } else if (infovar == 'Jagung Srikandi Putih') {
      cell7Text = 'Srikandi Putih';
      cell8Text = '8,1';
      cell9Text = 'Protein bermutu. Kurang tahan penyakit bulai. Umur panen 110 hari';
    
    } else if (infovar == 'Jagung BISI 12') {
      cell7Text = 'BISI 12';
      cell8Text = '';
      cell9Text = 'Potensi hasil tinggi, tahan terhadap karat daun, tahan rebah, beradaptasi baik pada musim kemarau di daerah yang cukup tersedia air, dan umur lebih genjah dari BISI-2. Baik ditanam untuk dataran rendah';
    
    } else if (infovar == 'Jagung BISI 16') {
      cell7Text = 'BISI 16';
      cell8Text = '11';
      cell9Text = 'Tahan terhadap penyakit karat daun dan bercak daun. Daerah pengembangan : Daerah yang sudah biasa menanam jagung hibrida pada musim kemarau dan penghujan, terutama yang mempunyai pola tanam musim jagung serta daerah-daerah pengembangan baru. Baik ditanam di dataran rendah sampai ketinggian 1000 m dpl ';
    
    } else if (infovar == 'Jagung NK 22') {
      cell7Text = 'NK 22';
      cell8Text = '12';
      cell9Text = 'Peka penyakit bulai, agak tahan terhadap hawar daun, dan karat. Beradaptasi pada dataran rendah sampai ketinggian 850 m dpl.';
    
    } else if (infovar == 'Jagung PIONEER 11') {
      cell7Text = 'PIONEER 11';
      cell8Text = '10';
      cell9Text = 'Tahan terhadap penyakit karat daun, agak rentan terhadap hawar daun H. turcicum, busuk tongkol Diplodia, busuk batang Pythium, dan rentan terhadap bulai serta busuk batang bakteri. Beradaptasi pada daerah dengan tingkat serangan rendah ';
    
    } else if (infovar == 'Jagung PIONEER 12') {
      cell7Text = 'PIONEER 12';
      cell8Text = '10-12';
      cell9Text = 'Tahan terhadap penyakit karat daun, busuk tongkol Diplodia, dan busuk batang bakteri; agak tahan terhadap bulai, hawar daun H. turcicum, dan busuk batang Pythium. Beradaptasi luas pada dataran rendah dan tinggi.';
    
    } else if (infovar == 'Jagung PIONEER 21') {
      cell7Text = 'PIONEER 21';
      cell8Text = '12';
      cell9Text = 'Tahan terhadap karat daun, bercak daun kelabu C. Zeae-maydis. Ketahanan sedang terhadap busuk tongkol Diplodia, virus, dan perkecambahan tongkol. Agak rentan terhadap busuk batang bakteri dan bulai. Potensi hasil tinggi dan bijinya berkualitas baik dengan pengisian biji yang baik. Batangnya cukup kokoh dan berperakaran baik sehingga cukup tahan terhadap kerobohan';
    
    } else if (infovar == 'Jagung PIONEER 23') {
      cell7Text = 'PIONEER 23';
      cell8Text = '12';
      cell9Text = 'Tahan terhadap bercak daun, kelabu C. maydis, dan busuk tongkol Diplodia. Cukup tahan terhadap busuk tongkol Gibberella, hawar daun, H. turcicum, karat daun, dan virus; serta ketahanan sedang terhadap perkecambahan tongkol. Agak rentan terhadap bulai dan rentan terhadap busuk batang bakteri. Potensi hasil tinggi, kualitas bijinya baik dengan pengisian yang baik. Batangnya kokoh dan perakaran baik, tahan terhadap kerobohan.';
    
    } else if (infovar == 'Jagung DK3') {
      cell7Text = 'DK3';
      cell8Text = '10';
      cell9Text = 'Tahan terhadap penyakit karat, toleran terhadap penyakit bulai. Tahan terhadap kekeringan (stress air) dan tahan rebah sesuai untuk daerah yang sering terjadi angin dengan kecepatan yang tinggi seperti di Langkat (Sumut).';
    
    } else if (infovar == 'Jagung Semar-8') {
      cell7Text = 'Semar-8';
      cell8Text = '9,0';
      cell9Text = 'Toleran terhadap penyakit bulai, umur sedang, umur panen 94 hari';
    
    } else if (infovar == 'Jagung Semar-10') {
      cell7Text = 'Semar-10';
      cell8Text = '9,0';
      cell9Text = 'Agak toleran terhadap penyakit bulai, biomas tinggi, umur panen 97 hari';
    
    } else if (infovar == 'Jagung Bima-1') {
      cell7Text = 'Bima-1';
      cell8Text = '8-9';
      cell9Text = 'Agak toleran terhadap penyakit bulai, stay green, umur panen 97 hari.';
    
    } else if (infovar == 'Jagung Bima-2 B') {
      cell7Text = 'Bima-2 Bantimurung';
      cell8Text = '11,0';
      cell9Text = 'Agak toleran terhadap penyakit bulai, stay green, umur panen 100 hari.';
    
    } else if (infovar == 'Jagung NK 11') {
      cell7Text = 'NK 11';
      cell8Text = '3,8';
      cell9Text = 'Tahan terhadap penyakit bulai, potensi hasil tinggi, dan perkembangan rambut baik.';
    
    } else if(infovar == 'Kedelai Wilis') {
      cell7Text = 'Kedelai Wilis';
      cell8Text = '2,5';
      cell9Text = 'Dapat beradaptasi secara luas, ukuran biji sedang, tahan rebah, dan tahan karat';

    } else if(infovar == 'Kedelai Kaba'){
      cell7Text = 'Kedelai Kaba';
      cell8Text = '2,6';
      cell9Text = 'Dapat beradaptasi secara luas, ukuran biji sedang, umur sedang, dan toleran karat';

    } else if(infovar == 'Kedelai Agromulyo'){
      cell7Text = 'Kedelai Agromulyo';
      cell8Text = '3,1';
      cell9Text = 'Memiliki umur 80 hari, ukuran biji besar, cocok untuk bahan baku tahu, tempe, dan susu.';

    } else if(infovar == 'Anjasmoro'){
      cell7Text = 'Kedelai Anjasmoro';
      cell8Text = '3,7';
      cell9Text = 'Dapat beradaptasi secara luas, memiliki umur 82 hari, ukuran biji besar, tahan rebah, dan polongnya tidak mudah pecah';

    } else if(infovar == 'Kedelai Grobongan'){
      cell7Text = 'Kedelai Grobongan';
      cell8Text = '3,4';
      cell9Text = 'Umur genjah 76 hari, ukuran biji besar, sesuai lahan kering pada musim hujan';

    } else if(infovar == 'Kedelai Detam 1'){
      cell7Text = 'Kedelai Detam 1';
      cell8Text = '3,45';
      cell9Text = 'Umur 84 hari, warna biji hitam, mengandung protein tinggi, sesuai untuk bahan kecap';

    } else if(infovar == 'Kedelai Detam 2'){
      cell7Text = 'Kedelai Detam 2';
      cell8Text = '2,96';
      cell9Text = 'Umur 82 hari, biji hitam, mengandung protein tinggi, dan cukup tahan dengan kondisi kering.';

    } else if(infovar == 'Kedelai'){
      cell7Text = 'Kedelai ';
      cell8Text = '2,6';
      cell9Text = '';

    } else if(infovar == 'Kedelai Tenggamus'){
      cell7Text = 'Kedelai Tenggamus';
      cell8Text = '2,6';
      cell9Text = 'Umur 88 hari dan adaptif dengan lahan kering masam';

    } else if(infovar == 'Kedelai Ijen'){
      cell7Text = 'Kedelai Ijen';
      cell8Text = '2,3';
      cell9Text = 'Umur 84 hari, toleran ulat grayak';

    } else if(infovar == 'Kedelai Gepak Kuning'){
      cell7Text = 'Kedelai Gepak Kuning';
      cell8Text = '2,83';
      cell9Text = 'Umur genjah 73 hari, ukuran biji kecil, rendemen tahu dan taoge tinggi';

    } else if(infovar == 'Kedelai Gepak Ijo'){
      cell7Text = 'Kedelai Gepak Ijo';
      cell8Text = '2,83';
      cell9Text = 'Umur 76 hari, rendemen tahu dan taoge tinggi, ukuran biji kecil';

    } else if(infovar == 'Kedelai Mutiara'){
      cell7Text = 'Kedelai Mutiara';
      cell8Text = '3,5';
      cell9Text = 'Umur 82 hari, ukuran biji besar, dan hasil tinggi';

    } else if(infovar == 'Kedelai Dering'){
      cell7Text = 'Kedelai Dering';
      cell8Text = '2,7';
      cell9Text = 'Umur genjah 73 hari, toleran kekeringan, tahan rebah, tahan penyakit karat, tahan hama pengisap polong, dan tahan hama penggerek.';

    } else if(infovar == 'Kedelai Devon 2'){
      cell7Text = 'Kedelai Devon 2';
      cell8Text = '2,89';
      cell9Text = 'Tahan rebah, tahan penyakit karat daun, hama penghisap polong, agak taha hama penggerek polong, peka penyakit virus SMV dan hama ulat grayak. Bobot 100 biji 2,89 gram';

    } else if(infovar == 'Kedelai Deja 1'){
      cell7Text = 'Kedelai Deja 1';
      cell8Text = '2,87';
      cell9Text = 'Tahan rebah, sangat toleran cekaman jenuh air mulai 14 hari sampai fase masak, bobot 100 biji 14,3 gram.';

    } else if(infovar == 'Kedelai Dena 1'){
      cell7Text = 'Kedelai Dena 1';
      cell8Text = '2,9';
      cell9Text = 'Toleran hingga naungan 50%, tahan rebah, tahan penyakit karat daun, rentan hama penghisap polong, dan hama ulat grayak. Bobot 100 biji 12,9 gram';
    
    } else if(infovar == 'Kedelai Biosoy'){
      cell7Text = 'Kedelai Biosoy';
      cell8Text = '3,3';
      cell9Text = 'Tahan karat daun, hama pegisap polong dan penggerek polong. Bobot 100 biji 21,74 gram.';
    } else if (infovar == 'Kacang Tanah Jerapah') {
      cell7Text = 'Varietas Jerapah';
      cell8Text = '1,92';
      cell9Text = 'Mampu beradaptasi luas, toleran terhadap kekeringan dan kemasaman. Berbisi 2 per polong (spanish) lonjong bulat, ukuran biji sedang (45-50 g/100 biji). Tahan terhadap layu bakteri, toleran terhadap penyakit bercak daun dan karat daun. Umr panen 90-95 hari';

    } else if (infovar == 'Kacang Tanah Anoa') {
      cell7Text = 'Varietas Anoa';
      cell8Text = '1,8';
      cell9Text = 'Tahan terhadap penyakit layu, tahan terhadap penyakit karat daun maupun tahan bercak coklat daun. Umur panennya 100-110 hari.';

    } else if (infovar == 'Kacang Tanah Tapir') {
      cell7Text = 'Varietas Tapir';
      cell8Text = '1,8-2';
      cell9Text = 'Tahan layu, umur panen 95-100 hari';

    } else if (infovar == 'Kacang Tanah Garuda Dua') {
      cell7Text = 'Varietas Garuda Dua';
      cell8Text = '2,3';
      cell9Text = 'Toleran terhadap layu. Umur panen 85-90 hari';

    } else if (infovar == 'Kacang Tanah Garuda Tiga') {
      cell7Text = 'Varietas Garuda Tiga';
      cell8Text = '2,25';
      cell9Text = 'Toleran terhadap layu. Umur panen 85-90 hari';

    } else if (infovar == 'Kacang Tanah Gajah') {
      cell7Text = 'Varietas Gajah';
      cell8Text = '1,2-1,8';
      cell9Text = 'Toleran terhadap layu. Umur panen 100-110 hari.';

    } else if (infovar == 'Kacang Tanah Bison') {
      cell7Text = 'Varietas Bison';
      cell8Text = '2,0';
      cell9Text = 'Berbiji 2 per polong (spanish), tahan penyakit karat, agak tahan bercak daun, agak tahan A. flavus, toleran penaungan, sesuai untuk tumpangsari dengan tanaman jagung atau ubikayu. Toleran terhadap klorosis dan beradaptasi baik di lahan kering kapuran. Umur panen 90-95 hari.';

    } else if (infovar == 'Kacang Tanah Domba') {
      cell7Text = 'Varietas Domba';
      cell8Text = '2,1';
      cell9Text = 'Berbiji 3-4/polong, (valencia) agak tahan penyakit karat, agak tahan bercak daun, tahan A. flavus, dan toleran klorosis sehingga beradaptasi baik di lahan kering kapuran. Umur panen 90-95 hari.';

    } else if (infovar == 'Kacang Tanah Tuban') {
      cell7Text = 'Varietas Tuban';
      cell8Text = '2,0';
      cell9Text = 'Varietas yang dimurnikan dari varietas lokal Tuban. Berbiji dua/polong (spanish), memiliki adaptasi baik di lahan kering Alfisol seperti di Tuban, agak toleran kekeringan, tahan penyakit layu, namun agak peka penyakit daun. Umur panen 90-95 hari.';

    } else {
      // Jika tidak ada data yang cocok dalam SharedPreferences
      cell7Text = 'Data tidak valid';
      cell8Text = 'Data tidak valid';
      cell9Text = 'Data tidak valid';
    }

    setState(() {
      tableData = [
        // ...
        [
          CellData(
              'Varietas',
              const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
          CellData(
              'Potensi Hasil (ton/ha)',
              const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
          CellData(
              'Karakteristik',
              const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
        ],
        [
          CellData(
              cell7Text,
              const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell8Text,
              const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          CellData(
              cell9Text,
              const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          ],        // Add more rows with different text styles as needed
      ];

      isDataLoaded =
          true; // Setelah data diinisialisasi, ubah nilai isDataLoaded menjadi true
    });
  }

  String _infoVar= "Tidak ada informasi benih";
  Future<void> _getInfoVar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String info = prefs.getString('infovar') ?? "Tidak Valid";
    setState(() {
      _infoVar = info;
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
          title: Text("Informasi Varietas $_infoVar", style: GoogleFonts.getFont('Poppins')),
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
          image: image13,
          fit: BoxFit.cover,
        ),
      ),
    ),
    // Latar belakang baru di atas background body dengan outline
    Positioned(
      top: iconSize * 17/10, // Posisi atas (sesuaikan dengan kebutuhan)
      bottom: iconSize * 2, // Posisi bawah (sesuaikan dengan kebutuhan)
      left: 85, // Posisi kiri (sesuaikan dengan kebutuhan)
      right: 85, // Posisi kanan (sesuaikan dengan kebutuhan)
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 226, 199, 116), // Warna latar belakang baru
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
                border: TableBorder.all(width: 1.0, color: Colors.black),
                defaultColumnWidth: FixedColumnWidth(columnWidth),
                children: _buildRows(context),
              ),
            ),
          ),
        ),
      ),
    ),
  ],
)


    );
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
