import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karebay/core/constants/auth/auth_sevice.dart';
import 'package:karebay/core/models/user_profile_model.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/costants.dart';
import '../../../core/constants/themes/widgets/widgets.dart';
import '../../../core/models/models.dart';
import '../../../core/providers/providers.dart';
import '../../../core/models/settings.dart' as local_settings;
import '../../presentations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? file;
  String userImage = '';
  String? userName;
  final ImagePicker _picker = ImagePicker();

  // pick an image
  void pickImage() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 95,
      );
      if (pickedImage != null) {
        setState(() {
          file = File(pickedImage.path);
        });
      }
    } catch (e) {
      log('error : $e');
    }
  }

  // get user data
  void getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          final profile = UserProfileModel.fromMap(userData.data()!);
          log('Firestore data: ${profile.toMap()}');
          setState(() {
            userName = profile.userName.isNotEmpty == true
                ? profile.userName
                : user.email;
            userImage = profile.profilePic.isNotEmpty
                ? profile.profilePic
                : (user.photoURL ?? ''); // Gunakan photoURL dari Google
          });
        } else {
          log('No document found for UID: ${user.uid}');
          setState(() {
            userName = user.email;
            userImage =
                user.photoURL ?? ''; // Gunakan photoURL jika Firestore kosong
          });
        }
      } else {
        log('No user logged in');
      }
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () async {
              authServicesProvider.signOut();
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Pallete.charcoalBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: BuildDisplayImage(
                    file: file,
                    userImage: userImage.isNotEmpty
                        ? userImage // Gunakan URL jika tersedia
                        : 'assets/default_avatar.png',
                  ),
                ),

                const SizedBox(height: 20.0),

                // user name
                Text('$userName',
                    style: Theme.of(context).textTheme.titleLarge),

                const SizedBox(height: 40.0),

                ValueListenableBuilder<Box<local_settings.Settings>>(
                    valueListenable: Boxes.getSettings().listenable(),
                    builder: (context, box, child) {
                      if (box.isEmpty) {
                        return Column(
                          children: [
                            // theme
                            SettingsTile(
                                icon: Icons.light_mode,
                                title: 'Theme',
                                value: false,
                                onChanged: (value) {
                                  final settingProvider =
                                      context.read<SettingsProvider>();
                                  settingProvider.toggleDarkMode(
                                    value: value,
                                  );
                                }),
                          ],
                        );
                      } else {
                        final settings = box.getAt(0);
                        return Column(
                          children: [
                            // theme
                            SettingsTile(
                                icon: settings!.isDarkTheme
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                                title: 'Theme',
                                value: settings.isDarkTheme,
                                onChanged: (value) {
                                  final settingProvider =
                                      context.read<SettingsProvider>();
                                  settingProvider.toggleDarkMode(
                                    value: value,
                                  );
                                }),
                          ],
                        );
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
