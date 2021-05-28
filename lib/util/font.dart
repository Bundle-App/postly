import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle notoSansTextStyle(double size, int value, FontWeight fontWeight) {
  return GoogleFonts.notoSans(
      fontSize: size, fontWeight: fontWeight, color: Color(value));
}
