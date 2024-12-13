import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karebay/core/constants/auth/auth_sevice.dart';
import 'package:karebay/core/constants/costants.dart';
import 'package:karebay/core/constants/themes/widgets/widgets.dart';
import 'package:karebay/features/presentations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  bool showSpinner = false;
  String? email;
  String? password;

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
                  'Welcome Back!',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    onChanged: (value) {
                      email = value;
                    },
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
                  child: TextField(
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
                  ),
                ),
                Gap.h40,
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        if (user.user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Login failed: $e'),
                          ),
                        );
                      } finally {
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    }
                  },
                  child: OnboardingButton(
                    title: 'Sign In',
                  ),
                ),
                Gap.h15,
                const Text('Or continue with google account'),
                Gap.h20,
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });

                    try {
                      final user =
                          await authServicesProvider.signInWithGoogle();

                      if (user != null) {
                        // Ambil email pengguna
                        String? email =
                            user.email; // Ambil email dari objek User

                        // Tampilkan email atau simpan di state
                        print(
                            'User  email: $email'); // Anda bisa menampilkan ini di UI

                        // Navigasi ke HomeScreen jika berhasil
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }
                    } catch (e) {
                      // Tampilkan pesan error kepada pengguna
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Google Sign-In failed: $e'),
                        ),
                      );
                    } finally {
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  },
                  child: Image.asset(
                    'assets/images/signinwithgoogle.png',
                    height: 60.0,
                  ),
                ),
                Gap.h15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Don\'t have account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(' Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
