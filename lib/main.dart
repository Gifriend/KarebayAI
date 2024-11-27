import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karebay/core/constants/themes/colors/pallete.dart';
import 'package:flutter/material.dart';
import 'package:karebay/features/presentations.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Karebay',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.whiteColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
