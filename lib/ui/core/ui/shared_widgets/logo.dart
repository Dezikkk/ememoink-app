import 'package:flutter/material.dart';

Widget buildLogo(BuildContext context) {
  const String logoPath = 'assets/icon/android.png';

  return Center(
    child: AspectRatio(
      aspectRatio: 1,
      child: ClipOval(child: Image.asset(logoPath, fit: BoxFit.cover)),
    ),
  );
}
