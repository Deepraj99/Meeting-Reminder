import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meeting_reminder/Home/methods.dart';
import 'package:meeting_reminder/Widgets/colors.dart';
import 'package:meeting_reminder/Widgets/drawer.dart';
import 'package:meeting_reminder/Widgets/multiSelecting.dart';
import 'package:meeting_reminder/Widgets/notifications.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _alarmTime;
  late String _alarmTimeString;
  late String meetTitle;
  late String meetDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kClockBackgroundColor.withOpacity(.70),
      appBar: AppBar(
        backgroundColor: kClockBackgroundColor,
        centerTitle: true,
        title: Text(
          'Meeting Reminder',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      drawer: navigationDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 20,
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
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              alarm.alarmTime,
                              style: GoogleFonts.lato(
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
                                  style: GoogleFonts.lato(
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
                              MeetingBottomSheet(context);

                              // scheduleAlarm();
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.add,
                                    color: Colors.white, size: 70.0),
                                SizedBox(height: 8),
                                Text(
                                  'Add Meeting',
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ]).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  MeetingBottomSheet(BuildContext context) async {
    TextEditingController _textFieldController = TextEditingController();
    var selectedDays = [];
    showModalBottomSheet(
      backgroundColor: kClockBackgroundColor,
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
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Set Meeting",
                        style:
                            GoogleFonts.lato(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      title: Text('Title',
                          style: GoogleFonts.lato(
                              fontSize: 20, color: Colors.white)),
                      trailing: InkWell(
                        child:
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Meet title',
                                    style: GoogleFonts.lato(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                                content: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      meetTitle = value;
                                    });
                                  },
                                  controller: _textFieldController,
                                  decoration: InputDecoration(
                                      hintText: "Max. 20 characters",
                                      hintStyle:
                                          GoogleFonts.lato(color: Colors.grey)),
                                ),
                                actions: <Widget>[
                                  InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        "Cancle",
                                        style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                  InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        "OK",
                                        style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        // codeDialog = meetTitle;
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Time',
                          style: GoogleFonts.lato(
                              fontSize: 20, color: Colors.white)),
                      trailing: InkWell(
                        child:
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                        onTap: () async {
                          var selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (selectedTime != null) {
                            final now = DateTime.now();
                            var selectedDateTime = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                selectedTime.hour,
                                selectedTime.minute);
                            _alarmTime = selectedDateTime;
                            setModalState(() {
                              _alarmTimeString =
                                  DateFormat('HH:mm').format(selectedDateTime);
                            });
                          }
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Repeat',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                      trailing: MultiSelecting(),
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Save",
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
