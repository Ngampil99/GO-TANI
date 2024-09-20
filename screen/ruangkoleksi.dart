import 'package:flutter/material.dart';

class RuangKoleksi extends StatefulWidget {
  const RuangKoleksi({super.key});

  @override
  State<RuangKoleksi> createState() => _RuangKoleksiState();
}

class _RuangKoleksiState extends State<RuangKoleksi> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenHeight * 0.12;
    return Scaffold (
      appBar: AppBar(
          foregroundColor: Colors.black,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,),
          extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/ruang koleksi.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: iconSize*3/2,
            left: (screenWidth/2) - iconSize*2,
            child: Container(
              height: iconSize*5,
              width: iconSize*7/2,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Image.asset('assets/sluet garu ngadek.png', fit: BoxFit.contain,)
            ),
          ),
          Positioned(
            bottom: iconSize*3/2,
            left: (screenWidth/2) - iconSize*9/2,
            child: Container(
              height: iconSize*5,
              width: iconSize*7/2,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Image.asset('assets/sluet pacul ngadek.png', fit: BoxFit.contain)
            ),
          ),
          Positioned(
            bottom: 0,
            right: iconSize/2,
            child: Container(
              height: iconSize*6,
              width: iconSize*6,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Image.asset('assets/sluet traktor.png', fit: BoxFit.contain)
            ),
          ),
          Positioned(
            bottom: iconSize*5,
            left: iconSize,
            child: Container(
              height: iconSize*2,
              width: iconSize*2,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Image.asset('assets/sluet capil.png', fit: BoxFit.contain)
            ),
          ),
          Positioned(
            bottom: 0,
            left: iconSize/2,
            child: Container(
              height: iconSize*5/2,
              width: iconSize*5/2,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Image.asset('assets/sluet gembor.png', fit: BoxFit.contain)
            ),
          ),
          Positioned(
            bottom: 0,
            left: iconSize*5/2,
            child: Container(
              height: iconSize*5/2,
              width: iconSize*5/2,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Image.asset('assets/sluet boot.png', fit: BoxFit.contain)
            ),
          )
          ])
    );
  }
}