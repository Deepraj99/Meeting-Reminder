import 'dart:developer';

import 'package:meeting_reminder/Widgets/alarm_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';
final String columnLink = 'link'; //

class AlarmHelper {
  static late Database _database;
  static late AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    _alarmHelper = AlarmHelper._createInstance();
    return _alarmHelper;
  }

  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "/alarm18.db";
    print(path);
    var database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        print("DB created");
        db.execute('''
          create table $tableAlarm ( 
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer,
          $columnLink text not null
           )
        '''); //$columnLink text not null,
      },
    );

    inspect(database);
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    inspect(alarmInfo);
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
    // temp = result;
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];
    print('get alarms ------------------------- ');
    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      print(element);
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });
    inspect(result);
    return _alarms;
  }

  Future<int> delete(String title) async {
    print("DELETING $title");
    var db = await this.database;
    return await db
        .delete(tableAlarm, where: '$columnTitle = ?', whereArgs: [title]);
  }
}
