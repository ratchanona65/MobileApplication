import 'package:flutter/material.dart';

enum MobileColors {
  white(title: "White", color: Color(0xFFFFFFFF)),
  black(title: "Black", color: Color(0xFF000000)),
  spaceGray(title: "Space Gray", color: Color(0xFF757575)),
  silver(title: "Silver", color: Color(0xFFC0C0C0)),
  blue(title: "Blue", color: Color(0xFF0000FF)),
  gold(title: "Gold", color: Color(0xFFFFD700)),
  midnightGreen(title: "Midnight Green", color: Color(0xFF004953)),
  purple(title: "Purple", color: Color(0xFF800080)),
  red(title: "Red", color: Color(0xFFFF0000)),
  roseGold(title: "Rose Gold", color: Color(0xFFB76E79)),
  yellow(title: "Yellow", color: Color(0xFFFFFF00)),
  green(title: "Green", color: Color(0xFF228B22));

  final String title;
  final Color color;

  const MobileColors({required this.title, required this.color});
}

String getColorName(String hexColor) {
  // แปลงสีเป็นเลขฐาน 16 ที่มี # นำหน้า
  final colorString = Color(int.parse(hexColor)).toString();
  final colorHex = colorString.split('(0x')[1].split(')')[0].toLowerCase();

  for (var color in MobileColors.values) {
    // แปลงสีเป็น String
    final mobileColorHex =
        color.color.value.toRadixString(16).padLeft(8, '0').toLowerCase();

    // เปรียบเทียบค่าสี
    if (mobileColorHex == colorHex) {
      return color.title; // ส่งคืนชื่อสีที่ตรงกัน
    }
  }
  return 'Unknown Color';
}
