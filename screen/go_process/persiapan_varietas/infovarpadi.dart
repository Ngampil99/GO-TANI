import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoVarPadi extends StatefulWidget {
  @override
  _InfoVarPadiState createState() => _InfoVarPadiState();
}

class _InfoVarPadiState extends State<InfoVarPadi> {
  late List<List<CellData>> tableData;
  String cell7Text = '';
  String cell8Text = '';
  String cell9Text = '';
  bool isDataLoaded = false; // Tambahkan variabel ini

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
      // Jika klik info benih padi
    if (infovar == 'Padi Hibrida') {
      cell7Text = 'Hibrida';
      cell8Text = '- Hanya sekali tanam\n\n- Kelebihan: hasil panen dapat mencapai dua kali lipat dari padi lokal, butiran padi lebih bagus, kualitas nasi lebih pulen dan wangi.\n\n- Kekurangan: Kualitas hasilnya akan berkurang jauh jika berasal dari tanaman turunannya, harga benihnya termasuk yang termahal.';
      cell9Text = 'Intani 1 dan 2, Rokan, SL 8 dan 11 SHS, Segera Anak, PP1, H1, Bernas Prima, SEMBADA B3, B5, B8 DAN B9, Long Ping (pusaka 1 dan 2), Adirasa-1, Adirasa-64, Hibrindo R-1, Hibrindo R-2, Manis-4 dan 5, Hipa4, Hipa 5 Ceva, Hipa 6 Jete, Hipa 7-10 11, MIKI 1-3, SL 8 SHS, SL 11 HSS dan Maro.';
      // Jika klik info benih jagung
    } else if (infovar == 'Padi Unggul') {

      cell7Text = 'Padi Unggul';
      cell8Text = '- Berada satu tingkat di bawah varietas hibrida\n\n- Dapat ditanam berkali-kali dengan kualitas yang sama.\n\n- Hasil panennya masih bisa dijadikan benih.\n\n- Harganya tidak semahal benih padi hibrida.\n\n- Hasil produksi dapat dikatakan baik, dapat mencapai 8-10 ton per hektar.\n\n- Keunggulan: tahan terhadap hama wereng coklat.';
      cell9Text = 'Inpara 1-8, Inpago 1-5, Inpari 1-21, Inpari 31, Inpari 33, Inpari 34 Salin Agritan, dan Inpari 35 Salin Agritan';

    } else if(infovar == 'Padi Lokal'){
      cell7Text = 'Padi Lokal';
      cell8Text = '- Varietas padi yang khusus berada di daerah tertentu.\n\n- Hanya cocok ditanam di daerah tertentu saja karena membutuhkan kesesuaian khusus untuk tumbuh dan menghasilkan padi.\n\n- Menghasilkan produksi sekitar 7-8 ton per hektar.\n\n- Rasa berasnya cenderung kurang enak.';
      cell9Text = 'Gropak (Kulon Progo), Indramayu, Dharma Ayu, Srimulih, Andel Jaran, Merong, Gundelan, Marong, Simenep, dan Ketan Lusi.';

    } else if(infovar == 'Padi Ketan'){
      cell7Text = 'Padi Ketan';
      cell8Text = '- Lebih lengket daripada padi nasi, sehingga tidak dijadikan makanan pokok.\n\n- Biasanya dijadikan bahan pembuatan tape ketan, bubur ketan, dan macam-macam makanan khas daerah.';
      cell9Text = 'Varian padi ketan merah, putih, dan hitam.';

    } else if(infovar == 'Padi Wangi'){
      cell7Text = 'Padi Wangi';
      cell8Text = 'Memiliki karakteristik beraroma wangi';
      cell9Text = 'Padi pandan wangi';

    } else if(infovar == 'Padi Pera'){
      cell7Text = 'Padi Pera';
      cell8Text = '- Menghasilkan nasi bertekstur pera atau sedikit keras. Tekstur ini berasal dari kadar amilosa yang tinggi. Semakin tinggi kadar amilosa, akan semakin terasa tekstur nasi tersebut.\n\n- Diproduksi populer di daerah Sumatera barat dan Riau.\n\n- Tidak hanya dijadikan nasi, tetapi juga menjadi bahan utama pembuatan bihun dan tepung beras.';
      cell9Text = 'Inpari 12 (amilosa 26,4%), Inpara 1 (27,9%), Inpara 3 (28,6%), Inpara 4 (29%), Inpari 17 (amilosa 26%), dan Hipa 4 (24,7%).';

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
              'Jenis Padi',
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
          CellData(
              'Jenis Varietas',
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
              GoogleFonts.getFont('Poppins',
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
          title: Text("Informasi Varietas $_infoVar",style: GoogleFonts.getFont('Poppins',
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),),
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
