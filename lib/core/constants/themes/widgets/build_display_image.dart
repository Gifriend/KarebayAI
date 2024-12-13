import 'dart:io';
import 'package:flutter/material.dart';

import '../utility/utility.dart';

class BuildDisplayImage extends StatelessWidget {
  const BuildDisplayImage({
    super.key,
    required this.file,
    required this.userImage,
    // required this.onPressed,
  });

  final File? file;
  final String userImage;
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60.0,
          backgroundColor: Colors.grey[200],
          backgroundImage: getImageToShow(),
        ),
      ],
    );
  }

  ImageProvider<Object> getImageToShow() {
    if (file != null) {
      return FileImage(file!);
    } else if (userImage.isNotEmpty && userImage.startsWith('http')) {
      return NetworkImage(userImage);
    } else if (userImage.isNotEmpty) {
      return FileImage(File(userImage));
    } else {
      return const AssetImage('assets/default_avatar.png');
    }
  }
}
