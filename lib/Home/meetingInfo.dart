import 'dart:ui';

class AlarmInfo {
  String alarmTime;
  String alarmDate;
  String description;
  bool isActive;
  List<Color> gradientColors;
  String days;
  AlarmInfo(this.alarmTime, this.alarmDate, this.description, this.isActive,
      this.gradientColors, this.days);
}
