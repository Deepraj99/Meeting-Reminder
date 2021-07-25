import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meeting_reminder/Home/methods.dart';
import 'package:meeting_reminder/Widgets/colors.dart';
import 'package:meeting_reminder/Widgets/notifications.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _alarmTime;
  late String _alarmTimeString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kClockBackgroundColor.withOpacity(.70),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Meeting Reminder',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: alarms.map<Widget>((alarm) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 32),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: alarm.gradientColors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: alarm.gradientColors.last.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.label,
                                    color: Colors.white, size: 24),
                                SizedBox(width: 8),
                                Text(
                                  alarm.description,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: new Icon(Icons.edit,
                                  size: 25, color: Colors.white),
                              highlightColor: Colors.pink,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          alarm.days,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              alarm.alarmTime,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "Join Meet",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              onTap: () {},
                            ),
                            IconButton(
                              icon: new Icon(Icons.delete,
                                  size: 25, color: Colors.white),
                              highlightColor: Colors.pink,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        // Text(
                        //   alarm.alarmDate,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.w700,
                        //     // fontSize: 24,
                        //   ),
                        // ),
                      ],
                    ),
                  );
                }).followedBy([
                  DottedBorder(
                    strokeWidth: 3,
                    color: Colors.white,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(24),
                    dashPattern: [5, 4],
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Consumer<NotificationService>(
                          builder: (context, model, _) => FlatButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            onPressed: () {
                              model.instantNotification(); // notification
                              _alarmTimeString =
                                  DateFormat('HH:mm').format(DateTime.now());
                              showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setModalState) {
                                      return Container(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          children: [
                                            FlatButton(
                                              onPressed: () async {
                                                var selectedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if (selectedTime != null) {
                                                  final now = DateTime.now();
                                                  var selectedDateTime =
                                                      DateTime(
                                                          now.year,
                                                          now.month,
                                                          now.day,
                                                          selectedTime.hour,
                                                          selectedTime.minute);
                                                  _alarmTime = selectedDateTime;
                                                  setModalState(() {
                                                    _alarmTimeString =
                                                        DateFormat('HH:mm')
                                                            .format(
                                                                selectedDateTime);
                                                  });
                                                }
                                              },
                                              child: Text(
                                                _alarmTimeString,
                                                style: TextStyle(fontSize: 32),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text('Repeat'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            ListTile(
                                              title: Text('Sound'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            ListTile(
                                              title: Text('Title'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            FloatingActionButton.extended(
                                              onPressed: () {},
                                              icon: Icon(Icons.alarm),
                                              label: Text('Save'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                              // scheduleAlarm();
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.add,
                                    color: Colors.white, size: 40.0),
                                SizedBox(height: 8),
                                Text(
                                  'Add Alarm',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir'),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  TextButton(
                    onPressed: () => logOut(context),
                    child: Text("LogOut"),
                  ),
                ]).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
