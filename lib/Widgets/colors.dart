import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:meeting_reminder/Home/meetingInfo.dart';

final Color iconColor = Color(0xFFB6C7D1);
final Color activeColor = Color(0xFF444974);
final Color textColor1 = Color(0XFFA7BCC7);
final Color textColor2 = Color(0XFF9BB3C0);
final Color facebookColor = Color(0xFF3B5999);
final Color googleColor = Color(0xFFDE4B39);
final Color backgroundColor = Color(0xFFECF3F9);

final kBackgroundColor = Color(0xFF2D2F41);
final kClockBackgroundColor = Color(0xFF444974);
final kClockOutlineColor = Color(0xFFEAECFF);

class GradientColors {
  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA73), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}

List<AlarmInfo> alarms = [
  AlarmInfo(
      DateFormat('kk:mm').format(DateTime.now()),
      DateFormat('dd-MM-yyyy').format(DateTime.now()),
      "Chemistry",
      true,
      GradientColors.sunset,
      "Mon-Tues"),
  AlarmInfo(
      DateFormat('kk:mm').format(DateTime.now()),
      DateFormat('dd-MM-yyyy').format(DateTime.now()),
      "Physics",
      true,
      GradientColors.sea,
      "Aug, 2nd"),
  AlarmInfo(
      DateFormat('kk:mm').format(DateTime.now()),
      DateFormat('dd-MM-yyyy').format(DateTime.now()),
      "Maths",
      true,
      GradientColors.sky,
      "Everyday"),
];
