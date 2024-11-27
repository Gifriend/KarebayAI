import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/costants.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confriemPasswordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isPasswordVisible2 = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Pallete.lightGrey,
        body: SingleChildScrollView(
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
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    labelText: 'Email Address',
                    filled: true,
                    fillColor: Pallete.whiteColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Gap.h20,
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    filled: true,
                    fillColor: Pallete.whiteColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
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
              Gap.h20,
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  controller: confriemPasswordController,
                  obscureText: isPasswordVisible2,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    filled: true,
                    fillColor: Pallete.whiteColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
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
              Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
