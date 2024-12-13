import 'package:flutter/material.dart';

import '../../costants.dart';

class OnboardingButton extends StatelessWidget {
  OnboardingButton({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 150.0,
      child: Center(
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Pallete.whiteColor,
          ),
        ),
      ),
      decoration: const BoxDecoration(
        color: Pallete.deepOceanBlue,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    );
  }
}
