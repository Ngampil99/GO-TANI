// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/models/api_response.dart';
import 'package:go_tani/models/user.dart';
import 'package:go_tani/services/user_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'loading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoadingScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Screen',style: GoogleFonts.getFont(
            'Poppins',
            textStyle: const TextStyle(color: Colors.white),
          ),),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
              image: DecorationImage(
                image: image14,
                fit: BoxFit.cover,
              ),
            ),
            ),
            Form(
              key: formkey,
              child: ListView(
                padding: const EdgeInsets.all(32),
                children: [
                  TextFormField(
                    style: GoogleFonts.getFont('Poppins'),
                      keyboardType: TextInputType.emailAddress,
                      controller: txtEmail,
                      validator: (val) =>
                          val!.isEmpty ? 'Invalid email address' : null,
                      decoration: kInputDecoration('Email'),cursorColor: Colors.black,),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: GoogleFonts.getFont('Poppins'),
                      controller: txtPassword,
                      obscureText: true,
                      validator: (val) =>
                          val!.length < 8 ? 'Required at least 8 chars' : null,
                      decoration: kInputDecoration('Password'),cursorColor: Colors.black,),
                  const SizedBox(
                    height: 10,
                  ),
                  loading
                      ? const Center(child: CircularProgressIndicator())
                      : kTextButton(
                          'Login',
                          () {
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                loading = !loading;
                                _loginUser();
                              });
                            }
                          },
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  kLoginRegisterHint('Belum punya akun? ', 'Register', () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Register()),
                        (route) => false);
                  })
                ],
              ),
            ),
          ],
        ));
  }
}
