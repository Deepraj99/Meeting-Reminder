class AlarmInfo {
  late int id;
  late String title;
  late DateTime alarmDateTime;
  late bool isPending;
  late int gradientColorIndex;
  late String days; //

  AlarmInfo({
    id,
    required this.title,
    required this.alarmDateTime,
    required this.isPending,
    required this.gradientColorIndex,
    // required this.days //
  });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) {
    return AlarmInfo(
      id: json["id"],
      title: json["title"],
      alarmDateTime: DateTime.parse(json["alarmDateTime"]),
      isPending: json["isPending"] == 0 ? false : true,
      gradientColorIndex: json["gradientColorIndex"],
      // days: json["days"] //
    );
  }
  Map<String, dynamic> toMap() => {
        // "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
        // "days": days //
      };
}
