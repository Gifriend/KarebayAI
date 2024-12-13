import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karebay/features/presentations.dart';
import '../../../core/constants/costants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Simulasi loading splash screen (opsional)
    await Future.delayed(const Duration(seconds: 2));
    // Periksa apakah user sudah login
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Jika user sudah login, navigasi ke HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Jika belum login, navigasi ke LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Karebay',
              style: TextStyle(
                color: Pallete.charcoalBlue,
              ),
            ),
            Text(
              'Your Personal Assistant',
              style: TextStyle(
                color: Pallete.charcoalBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
