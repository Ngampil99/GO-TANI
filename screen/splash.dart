import 'package:flutter/material.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/models/api_response.dart';
import 'package:go_tani/screen/loading.dart';
import 'package:go_tani/services/user_services.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityLevel = 1.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        opacityLevel = 0.0;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                NextScreen(),
            transitionDuration:
                const Duration(milliseconds: 500), // Durasi transisi
            opaque: false,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 15, 80, 135),
          image: DecorationImage(
            image: image12,
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
      ),
      AnimatedOpacity(
        opacity: opacityLevel,
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenHeight / 8,
                height: screenHeight / 8,
                child: image1,
              ),
              SizedBox(
                width: screenHeight / 3,
                height: screenHeight / 3,
                child: image2,
              ),
              SizedBox(
                width: screenHeight / 3,
                height: screenHeight / 3,
                child: image3,
              ),
              // Image.asset(
              //   'assets/um.png',
              //   width: screenHeight / 3,
              //   height: screenHeight / 3,
              //   fit: BoxFit.contain,
              // ),
              SizedBox(
                width: screenHeight / 8,
                height: screenHeight / 8,
                child: image4,
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}

class NextScreen extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  double opacityLevel = 1.0;

  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      });
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoadingScreen()),
              (route) => false);
        });
      } else if (response.error == unauthorized) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        opacityLevel = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 15, 80, 135),
          image: DecorationImage(
            image: image12,
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
      ),
      AnimatedOpacity(
        opacity: opacityLevel,
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: SizedBox(
            width: screenHeight / 2,
            height: screenHeight / 2,
            child: image11,
          ),
        ),
      ),
    ]));
  }
}
