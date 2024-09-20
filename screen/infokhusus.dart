import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class InfoKhusus extends StatefulWidget {
  @override
  _InfoKhususState createState() => _InfoKhususState();
}

class _InfoKhususState extends State<InfoKhusus> {
  String infokhusus = '';
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
    getInfoKhusus();
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

  Future<Widget> getInfoKhusus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? infoKhusus = pref.getString('infokhusus');
    String? benih = pref.getString('benih');

    if ((infoKhusus == 'pemilihan varietas') && (benih == 'padi')) {
      return _buildRichText(
        'Pemilihan Varietas\n- Pertanian padi organik dilakukan dengan memilih benih tanaman non-hibrida. Bibit non hibrida akan mempertahankan keanekaragaman hayati dan memungkinkan untuk ditanam secara organik.\n- Varietas padi yang cocok ditanam secara organik  adalah varietas yang memiliki ketahanan yang baik terhadap hama dan penyakit. Contoh jenis varietas yang dapat ditanam antara lain adalah Rojolele, Mentik, Pandan, dan Lestari.\n- Benih yang dipilih harus berasal dari benih organik pula dan tidak bisa menggunakan benih dari hasil rekayasa genetika.',
        Colors.black,
      );
    } else if (infoKhusus == 'pemilihan benih') {
      return _buildRichText(
        '- Disarankan menggunakan benih yang berasal dari tumbuhan yang ditumbuhkan secara organik.\n- Jika benih organik tidak tersedia, maka: pada tahap awal dapat digunakan benih tanpa perlakuan pestisida sintetis, benih yang sudah mendapat perlakuan pestisida sintetis, perlu dilakukan tindakan pencucian untuk meminimalkan residu pestisida sintetis.\n- Media benih tidak menggunakan bahan sebagai berikut: urea, Single/double/triple super phosphate; Amonium sulfat; Kalium klorida; Kalium nitrat; Kalsium nitrat; Pupuk kimia sintetis lain; EDTA chelates; Zat pengatur tumbuh (ZPT) sintetis; Biakan mikroba yang menggunakan media kimia sintetis; dan Semua produk yang mengandung GMO.\n- Tidak boleh berasal dari hasil rekayasa genetika.',
        Colors.black,
      );
    } else if ((infoKhusus == 'pengolahan lahan') && (benih == 'padi')) {
      return _buildRichText(
        'Lahan dan Penyiapan Lahan\n- Lahan bekas pertanian konvensional harus mengalami periode konversi (perubahan) paling sedikit 2 tahun sebelum penebaran benih, untuk tanaman tahunan selain padang rumput paling sedikit 3 tahun sebelum panen hasil pertama produk organik atau paling sedikit 12 bulan untuk kasus tertentu. \n- Jika seluruh lahan tidak dapat dikonversi secara bersamaan, maka boleh dikerjakan secara bertahap.\n- Areal yang telah dikonversi untuk produksi pangan organik tidak boleh diubah (kembali seperti semula atau sebaliknya) antara metode produksi pangan organik dan konvensional.\n- Tidak menyiapkan lahan dengan cara pembakaran, termasuk pembakaran sampah.\nPengelolaan Kesuburan Tanah\n- Disarankan menanam kacang-kacangan (leguminosae), pupuk hijau atau tanaman berakar dalam melalui program rotasi tahunan yang sesuai.\n- Disarankan mencampurkan bahan organik seperti kotoran ternak ke dalam tanah, baik dalam bentuk kompos maupun segar.\n Disarankan menggunakan bahan biodinamik dari debu atau bubuk karang tinggi mineral, kotoran hewan atau tanaman untuk menyuburkan, membenahi dan untuk aktivitas biologi tanah.\n- Sisa-sisa tanaman dan bahan lainnya harus dikomposkan dengan baik dan tidak boleh dibakar.\n- Disarankan menggunakan bahan penyubur tanah sebagai berikut: kotoran ternak, urine ternak, kompos sisa tanaman, kompos media jamur merang, kompos limbah organik sayuran, dolomit, gipsum, kapur klorida, batuan fosfat, gunao, terak baja, batu kalium, garam kalium tambang, sulfat kalium, garam epsom/magnesium sulfat, natrium klorida, Unsur mikro (boron, tembaga, besi, mangan, molibdenum, seng), Stone meal; Liat/clay (bentonit, perlite, zeolit); Vermiculite; Batu apung; Gambut; Rumput laut; Hasil samping industri gula (vinasse); Hasil samping industri pengolahan kelapa sawit, kelapa, coklat, kopi (termasuk tandan sawit kosong, lumpur sawit, kulit coklat dan kopi); dan Zat Pengatur Tumbuh (ZPT).\n- Tidak disarankan menggunakan pupuk kimia sintetis yang berlebihan, kotoran hewan secara langsung, kotoran manusia, dan kotoran babi.\n- Penyiapan Lahan\n- Lahan untuk pertanian organik harus terbebas dari residu-residu kimia seperti pupuk atau obat-obatan sintesis. Proses transisi dari sistem konvensional ke sistem organik biasanya membutuhkan waktu 1-3 tahun.\n- Jika air dalam areal cukup banyak, semakin banyak unsur hara dalam kaloid yang dapat larut, sehingga makin banyak unsur hara yang dapat diserap akar tanaman. \n- Perhatikan lingkungan sekitar lahan. Pencemaran zat kimia dari kebun tetangga atau limbah rumah tetangga dapat merusak sistem pertanian organik, karena zat-zat pencemar dapat berpindah ke lahan organik karena terbawa oleh air dan udara.\n- Prinsip pengolahan tanah adalah untuk memecahkan bongkahan-bongkahan tanah sawah  hingga menjadi lunak dan sangat halus, serta harus memperhatikan ketersediaan air yang cukup.',
        Colors.black,
      );
    } else if ((infoKhusus == 'penanaman') && (benih == 'padi')) {
      return _buildRichText(
        'Penanaman\n- Syarat bibit yang baik untuk dipindahkan ke lahan adalah memiliki tinggi sekitar 25 cm, 5-6 helai daun, batang bawah besar dan keras, bebas dari hama penyakit, dan jenisnya seragam.\n- Penggunaan Bibit Muda (10-15 Hari Setelah Sebar) sebanyak 1-3 batang per rumpun agar memberikan pertumbuhan dan perkembangan akar yang lebih baik, anakan lebih banyak, tanaman dapat menampilkan potensi genetiknya secara penuh sesuai daya dukung lahan, dan mampu beradaptasi dengan lingkungan lebih cepat dibandingkan dengan tanaman dari bibit yang lebih tua.\n- Hal penting yang perlu diperhatikan: luas area persemaian ≥ 5% dari areal sawah yang akan ditanami agar mengakibatkan bibit tumbuh kecil dan lemah karena lahan persemaian yang terlalu sempit dan rapat.',
        Colors.black,
      );
    } else if ((infoKhusus == 'pemupukan') && (benih == 'padi')) {
      return _buildRichText(
        'Pemupukan\n- Dianjurkan menerapkan teknik pemupukan berimbang, yaitu pemberian pupuk yang disesuaikan dengan status hara tanah dan kebutuhan tanaman untuk mencapai produktivitas yang optimal dan berkelanjutan. \n- Pupuk diberikan saat tanah kekurangan unsur hara saja. Dapat dilihat dari notifikasi sensor NPK yang ada pada aplikasi.',
        Colors.black,
      );
    } else if ((infoKhusus == 'pemupukan') && (benih == 'jagung')) {
      return _buildRichText(
        '- Disarankan untuk menggunakan pupuk organik dari kotoran kambing, diikuti kascing, kotoran sapi, dan kompos indore untuk membantu meningkatkan hasil bobot tongkol tanpa kelobot.\n- Pupuk diberikan dalam jumlah yang besar karena kandungan haranya yang rendah, waktu pemberian harus diberikan sebelum tanam agar pupuk organik dapat mengalami proses dekomposisi dan mineralisasi sehingga tersedia bagi tanaman. \n- Pupuk hijau sebelum dibenamkan dipotong-potong dalam bentuk segar dengan ukuran 2-3 cm, sedangkan kotoran sapi diberikan dalam bentuk kompos.',
        Colors.black,
      );
    } else if ((infoKhusus == 'pemupukan') && (benih == 'kedelai')) {
      return Column(children: [
        _buildRichText(
          'Disarankan menggunakan pupuk organik seperti pupuk kandang ayam, sapi, kambing. Untuk memperbaiki kualitas buah diperlukan dosis 10-15 ton/ha.\nPenambahan larutan pupuk anorganik NPK atau penggunaan giberelin dapat meningkatkan pertumbuhan dan kualitas buah kedelai (penggunaan giberelin lebih baik). ',
          Colors.black,
        ),
        Table(
            border: TableBorder.all(), // Tambahkan garis
            children: [
              TableRow(children: [
                TableCell(
                  child: Center(
                    child: Text('Rentang pH',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont('Poppins',
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text('Kategori',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont('Poppins',
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text('Rekomendasi',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont('Poppins',
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Center(
                    child: Text('>6,5',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.getFont('Poppins')),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text('Asam',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.getFont('Poppins')),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                        '- Menambahkan bubuk kapur (bubuk, butiran, pelet, dan kristal)./n- Menggunakan serbuk kayu) menggunakan potassium. Penggunaan tidak bersamaan dengan urea, karena keduanya bisa menghasilkan gas amonia.\n- Menggunakan abu kayu. Pengaplikasiannya tidak mengenai akar/bibit tanaman agar tidak merusaknya.Efektif di lahan berpasir.',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.getFont('Poppins')),
                  ),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Center(
                    child: Text('>6,5',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.getFont('Poppins')),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text('Basa',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.getFont('Poppins')),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                        '- Memberikan bubuk belerang atau sulfur.\n- Memberikan ampas teh ataupun kopi.\n- Menggunakan material organik seperti pupuk kompos atau pupuk kandang',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.getFont('Poppins')),
                  ),
                ),
              ]),
            ])
      ]);
    } else if ((infoKhusus == 'pemeliharaan') && (benih == 'jagung')) {
      return Column(children: [
        _buildRichText(
            'Pengendalian Organisme Pengganggu Tanaman (OPT)\n- Disarankan menanam tanaman refugia yang merupakan teknik pengendalian hama berbasis ekologi. \n- Menggunakan tanaman refugia berbunga seperti kenikir, bunga kertas, marigold, dan sebagainya.\n- Tanaman refugia berfungsi sebagai perlindungan, sumber pakan atau sumberdaya yang lain bagi musuh alami seperti predator dan parasitoid.\n Disarankan menggunakan pestisida alami untuk mengendalikan atau mengurangi serangan hama dan penyakit jagung',
            Colors.black),
        Table(children: [
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Nama Umum',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Nama Latin',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Fungsi',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Daun Mimba',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Azadirachta indica',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Insektisida',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Tembakau',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Nicotiana tabacum',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Fungisida, Repellent',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Serai',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Callosobruchus analis',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Insektisida',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Daun Sirsak',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Annona muricata',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Insektisida',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Brotowali',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Tinospora sp.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Insektisida',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Akar Tuba',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Derris elliptica',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Moluskisida, insektisida',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Ki Pahit',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Tithonia tagitrifolia',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Repellent',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Gadung',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Dioscorea composite',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Rodentisida',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Babandotan',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Ageratum conyzoides',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Insektisida',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Srikaya',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Annona squamosa',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Insektisida',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Center(
                child: Text('Bawang Putih',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Allium sativum',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins',
                        fontStyle: FontStyle.italic)),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Insektisida, Fungsisida',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.getFont('Poppins')),
              ),
            ),
          ]),
        ])
      ]);
    } else if ((infoKhusus == 'pemeliharaan') && (benih == 'padi')) {
      return Column(children: [
        _buildRichText(
          'Sumber Air\nSumber mata air secara langsung yang tidak terkontaminasi oleh bahan kimia dan cemaran lain yang membahayakan.\nJika air telah terkontaminasi cemaran, maka harus dilakukan langkah untuk mengurangi cemaran melalui filtrasi dengan ukuran 0,1% dari total luas lahan. Disarankan untuk menanam eceng gondok di sekitar sumber air.\nPenggunaan air harus sesuai dengan prinsip konservasi.\nPengendalian Organisme Pengganggu Tanaman (OPT) dan Pemeliharaan Tanaman\n- Tidak disarankan menggunakan bahan kimia sintetis dan organisme atau produk hasil rekayasa genetika.\n- Tidak melakukan proses pembakaran dalam pengendalian gulma.\n- Menerapkan sistem pengendalian hama dan penyakit yang terpadu sehingga dapat menekan kerugian akibat OPT.\n- OPT harus dikendalikan dengan salah satu atau kombinasi dari cara seperti berikut: pemilihan varietas yang sesuai;  program rotasi/pergiliran tanaman yang sesuai; pengolahan tanah secara mekanik; penggunaan tanaman perangkap; penggunaan pupuk hijau dan sisa potongan tanaman’ pengendalian mekanis seperti penggunaan perangkap, penghalang, cahaya dan suara; pelestarian dan  pemanfaatan musuh alami melalui pelepasan musuh alami dan penyediaan habitat yang cocok seperti pagar hidup dan zona penyangga ekologi; pengendalian gulma dengan pemanasan.\n- Jika terdapat kasus yang membahayakan atau ancaman serius terhadap tanaman, dan tindakan pencegahan di atas tidak efektif, dapat digunakan bahan sebagai berikut:\n1. Pestisida nabati (kecuali nikotin yang diisolasi dari tembakau)\n2. Tembakau yang diekstrak dengan air dan langsung digunakan.\n3. Propolis\n4. Minyak tumbuhan dan binatang\n5. Rumput laut, garam laut dan air laut.\n6. Gelatin\n7. Lecitin\n8. Casein\n9. Asam alami (vinegar)\n10. Produk fermentasi dari Aspergillus\n11. Ekstrak jamur\n12. Ekstrak Chlorella\n13. Senyawa anorganik (campuran bordeaux, tembaga hidroksida, tembaga oksiklorida)\n14. Campuran burgundy\n15. Garam tembaga\n16. Belerang (sulfur)\n17. Bubuk mineral (stone meal, silikat)\n18. Tanah yang kaya diatom\n19. Silikat clay\n20. Natrium silikat\n21. Natrium bikarbonar\n22. Kalium permanganat\n23. Minyak parafin\n24. Mikroorganisme (bakteri, virus, jamur) misalnya Bacillus thuringiensis \n25. Karbondioksida dna gas nitrogen\n26. Sabun kalium (sabun lembut)\n27. Etil alkohol\n28. Serangga jantan yang telah disterilisasi\n29. Preparat pheromone dan atraktan nabati\n30. Obat-obatan jenis metaldehyde yang berisi penangkan untuk spesies hewan besar dan dapat digunakan untuk perangkap.\nPenyiangan\n- Direkomendasikan melakukan penyiangan dengan menggunakan alat gosrok atau landak karena tidak menggunakan bahan kimia, ramah lingkungan, ekonomis, dan dapat meningkatkan udara di dalam tanah serta merangsang pertumbuhan akar padi lebih baik.\nPengairan\n- Untuk menghindari aliran air yang mengandung bahan kimia, disarankan mencari lahan sawah yang menggunakan masukan air dari mata air terdekat, atau bisa mengambil dari saluran air yang cukup besar,\n- Disarankan menanam eceng gondok di saluran pemasukan air untuk menetralisir racun atau bahan kimia yang masuk ke petakan.\n- Agar pertumbuhan dan produktivitas tanaman menjadi baik pengairan, disarankan menerapkan teknologi hemat air dengan cara pengairan berselang.\n  a. Penggenangan Air\nPenggenangan air tidak boleh sembarangan, harus disesuaikan dengan fase pertumbuhan tanaman.',
          Colors.black,
        ),
        Table(
          border: TableBorder.all(), // Tambahkan garis
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Text(
                      "Awal Pertumbuhan (Mulai Pembentukan Anakan)",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      "Pembentukan Anakan",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                      child: Text(
                    "Masa Bunting",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
                TableCell(
                  child: Center(
                      child: Text(
                    "Pembungaan",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ],
            ),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text(
                      'Petak sawah digenangi air setinggi 2-5 cm dari permukaan tanah selama 15 hari.',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text(
                      'Ketinggian air ditingkatkan dan dipertahankan antara 3-5 cm, hingga tanaman terlihat bunting.\n\nKetinggian air lebih dari 5 cm akan akan menghambat pembentukan anakan atau tunas. Jika kurang dari 3 cm, gulma akan mudah tumbuh.',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text(
                      'Dibutuhkan air dalam jumlah cukup banyak dengan ketinggian sekitar 10 cm. Tidak boleh kekurangan air karena dapat berakibat matinya primordia.',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text(
                      'Ketinggian air dipertahankan antara 5-10 cm. Jika tampak keluar bunga, sawah perlu dikeringkan selama 4-7 hari agar pembungaan berlangsung serentak. Ketika bunga muncul serentak, air segera dimasukkan kembali agar makanan dan air dapat terserap banyak oleh akar tanaman. ',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
          ],
        ),
        _buildRichText(
            '  b. Pengeringan Sawah\n- Tidak dilakukan pada semua fase pertumbuhan tanaman, tetapi hanya pada fase sebelum bunting dan fase pemasakan biji.\n- Air dikeluarkan dengan membuka saluran pembuangan di pinggir lahan, sehingga air keluar melalui alur yang sudah dibuat di tengah-tengah lahan.',
            Colors.black),
        Table(
          border: TableBorder.all(), // Tambahkan garis
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Text(
                      "Menjelang Bunting",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      "Pemasakan Biji",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text(
                      'Dilakukan untuk menghentikan pembentukan anakan atau tunas karena tanaman mulai memasuki fase pertumbuhan generatif agar tanaman berbunga serentak. Lama pengeringan lahan 4-5 hari.',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text(
                      'Dilakukan untuk menyeragamkan biji dengan mempercepat pemasakan biji. Patokan pengeringan adalah saat seluruh bulir padi mulai menguning. Jika dilakukan sebelum semua bulir menguning, berakibat malai padi menjadi kosong. Pengeringan dilakukan hingga saat padi dipanen.',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
          ],
        ),
        _buildRichText(
            '3. Pengendalian Hama dan Penyakit\n- Disarankan memanfaatkan tanaman refugia, yaitu pertanaman beberapa jenis tumbuhan yang dapat menyediakan tempat perlindungan, sumber pakan atau sumberdaya yang lain bagi musuh alami seperti predator dan parasitoid.\n- Tanaman refugia ditanam di galengan (pinggiran lahan) sebagai plant border untuk menjaga padi dari serangan hama karena hama akan lebih tertarik dengan warna dan aroma tanaman refugia.\n- Tanaman refugia yang biasa ditanam cenderung memiliki warna mencolok dan aroma yang khas, seperti kenikir dan bunga kertas.\n- Hal-hal yang terlarang dalam budidaya padi organik adalah menggunakan obat-obatan kimia seperti pestisida, fungisida, bakterisida, dan sejenisnya',
            Colors.black),
        Table(
          border: TableBorder.all(), // Tambahkan garis
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Text(
                      "Jenis Tumbuhan",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      "Bagian Tumbuhan",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      "Hama Penyakit yang Dikendalikan",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Bawang Putih',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Umbi',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Berbagai jenis wereng dan penyakit karena jamur',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Jeringau',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Rimpang',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Jamur',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Paitan',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Seluruh Tanaman',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Berbagai jenis wereng',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Tembakau',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Daun',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Berbagai jenis wereng',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Sirsak',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Daun',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Berbagai Jenis Wereng',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Sere',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Daun',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Berbagai Jenis Wereng',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Mimba',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Daun dan Biji',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Walang sangit, ganjur dan penggerek batang',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Mindi',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Daun dan Biji',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Walang sangit, ganjur dan penggerek batang',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Lengkuas',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Umbi',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Walang sangit, ganjur dan penggerek batang',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Gadung KB',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Umbi',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Walang sangit, ganjur dan penggerek batang',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Gadung Racun',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Umbi',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Tikus',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Kunyit',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Rimpang',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Tikus',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Bawang Merah',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Umbi',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Berbagai penyakit karena jamur',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Cabai Merah',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Buah',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Berbagai penyakit karena jamur',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Cengkih',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Daun',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Berbagai penyakit karena jamur',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont('Poppins')),
                ),
              ),
            ]),
          ],
        ),
      ]);
    } else {
      return _buildRichText(
        'tidak didefinisikan',
        Colors.black,
      );
    }
  }

  Widget _buildRichText(String mainText, Color textColor) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: mainText,
            style: GoogleFonts.getFont('Poppins', fontSize: 14, color: textColor
                // tambahkan style lain yang Anda inginkan di sini
                ),
          ),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth * 90 / 100;
    double containerHeight = screenHeight * 90 / 100;
    double iconSize = screenHeight * 0.12;

    return Scaffold(
        appBar: AppBar(
            title: Text("Tips Pertanian Organik",
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
              future: getInfoKhusus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Center(
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
                      padding: const EdgeInsets.all(0),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(15),
                        child: snapshot.data as Widget,
                      ),
                    ));
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ]));
  }
}
