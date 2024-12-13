import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karebay/core/constants/themes/widgets/onboarding_button.dart';
import 'package:karebay/features/presentations.dart';

import '../../../../core/constants/costants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confriemPasswordController =
      TextEditingController();
  bool isPasswordVisible = true;
  bool isPasswordVisible2 = true;
  String? email;
  String? password;
  String? confirmPassword;
  bool showSpinner = false;
    final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Pallete.lightGrey,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 130.0),
                  child: Text(
                    'Hello!',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Text(
                  'Join With Us!',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    controller: emailController,
                    decoration: emailInput,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email harus diisi';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Email harus beriisi email yang valid';
                      }
                      return null;
                    },
                  ),
                ),
                Gap.h20,
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: isPasswordVisible,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      filled: true,
                      fillColor: Pallete.whiteColor,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          borderSide: BorderSide.none),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kata Sandi tidak boleh kosong';
                      }
                      if (value.length < 8) {
                        return 'Kata sandi harus minimal 8 karakter';
                      }
                      if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                        return 'Kata sandiri minimal harus berisi huruf besar';
                      }
                      if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
                        return 'Kata sandi minimal harus ada 1 simbol';
                      }
                      return null;
                    },
                  ),
                ),
                Gap.h20,
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    controller: confriemPasswordController,
                    obscureText: isPasswordVisible2,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      labelText: 'Confirm Password',
                      filled: true,
                      fillColor: Pallete.whiteColor,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          borderSide: BorderSide.none),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible2 = !isPasswordVisible2;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi kata sandi harus diisi';
                      }
                      if (value != passwordController.text) {
                        return 'Kata sandi tidak cocok';
                      }
                      return null;
                    },
                  ),
                ),
                Gap.h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Already have account? '),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text('Sing in'),
                      ),
                    ),
                  ],
                ),
                Gap.h40,
                GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) { 
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser  = await _auth.createUserWithEmailAndPassword(
                          email: emailController.text.trim(), 
                          password: passwordController.text.trim(), 
                        );
                        if (newUser .user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      } finally {
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    }

                    },
                    child: OnboardingButton(title: 'Sign Up')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
