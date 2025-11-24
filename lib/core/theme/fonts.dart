import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFontsStyle {
  // اسم الخط الأساسي
  static const String primaryFont = 'ADLaM Display';

  // أحجام الخطوط
  static TextStyle size10 = GoogleFonts.aBeeZee(fontSize: 10.sp);
  static TextStyle size12 = GoogleFonts.aBeeZee(fontSize: 12.sp);
  static TextStyle size14 = GoogleFonts.aBeeZee(fontSize: 14.sp);
  static TextStyle size16 = GoogleFonts.aBeeZee(fontSize: 16);

  static TextStyle size18 = GoogleFonts.aBeeZee(fontSize: 18.sp);
  static TextStyle size20 = GoogleFonts.aBeeZee(fontSize: 20.sp);
  static TextStyle size22 = GoogleFonts.aBeeZee(fontSize: 22.sp);
  static TextStyle size24 = GoogleFonts.aBeeZee(fontSize: 24.sp);
  static TextStyle size26 = GoogleFonts.aBeeZee(fontSize: 26.sp);

  // أوزان الخط
  static TextStyle bold(TextStyle style) =>
      style.copyWith(fontWeight: FontWeight.bold);

  static TextStyle semiBold(TextStyle style) =>
      style.copyWith(fontWeight: FontWeight.w600);

  static TextStyle medium(TextStyle style) =>
      style.copyWith(fontWeight: FontWeight.w500);

  static TextStyle light(TextStyle style) =>
      style.copyWith(fontWeight: FontWeight.w300);
}
