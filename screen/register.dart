import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:go_tani/const.dart';
import 'package:go_tani/main.dart';
import 'package:go_tani/models/api_response.dart';
import 'package:go_tani/models/user.dart';
import 'package:go_tani/services/user_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmController = TextEditingController();

  void _registerUser() async {
    ApiResponse response = await register(
        nameController.text, emailController.text, passwordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // Save and redirect to home
  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: GoogleFonts.getFont(
            'Poppins',
            textStyle: const TextStyle(color: Colors.white), // Ubah warna teks di sini
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
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                child: Column(
                  children: [
                    TextFormField(
                      style: GoogleFonts.getFont('Poppins'),
                      controller: nameController,
                      validator: (val) => val!.isEmpty ? 'Invalid name' : null,
                      decoration: kInputDecoration('Name'),
                      cursorColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: GoogleFonts.getFont('Poppins'),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          val!.isEmpty ? 'Invalid email address' : null,
                      decoration: kInputDecoration('Email'),
                      cursorColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: GoogleFonts.getFont('Poppins'),
                      controller: passwordController,
                      obscureText: true,
                      validator: (val) =>
                          val!.length < 8 ? 'Required at least 8 chars' : null,
                      decoration: kInputDecoration('Password'),
                      cursorColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: GoogleFonts.getFont('Poppins'),
                      controller: passwordConfirmController,
                      obscureText: true,
                      validator: (val) => val != passwordController.text
                          ? 'Confirm password does not match'
                          : null,
                      decoration: kInputDecoration('Confirm password'),
                      cursorColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    loading
                        ? const Center(child: CircularProgressIndicator())
                        : kTextButton(
                            'Register',
                            () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  loading = !loading;
                                  _registerUser();
                                });
                              }
                            },
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    kLoginRegisterHint('Already have an account? ', 'Login',
                        () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
