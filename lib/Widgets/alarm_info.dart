class AlarmInfo {
  int id = 1;
  late String title;
  late DateTime alarmDateTime;
  late int isPending;
  late int gradientColorIndex;
  late String link; //

  AlarmInfo({
    // id,
    required this.title,
    required this.alarmDateTime,
    required this.isPending,
    required this.gradientColorIndex,
    required this.link, //
  });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) {
    return AlarmInfo(
        // id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"], // == 0 ? false : true,
        gradientColorIndex: json["gradientColorIndex"],
        link: json["link"]);
  }
  Map<String, dynamic> toMap() => {
        // "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
        "link": link,
      };
}
