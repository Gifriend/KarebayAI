import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karebay/features/presentations.dart';
import 'package:karebay/features/splash/presentations/splash_screen_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  Widget build(BuildContext context) {
     ref.listen<AsyncValue<void>>(splashScreenControllerProvider,
        (previous, next) {
      if (next is AsyncData) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    });
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}