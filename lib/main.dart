import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meeting_reminder/Home/authenticate.dart';
import 'package:meeting_reminder/Widgets/notifications.dart';
import 'package:provider/provider.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        child: MaterialApp(
          title: 'Meeting Reminder',
          debugShowCheckedModeBanner: false,
          home: Authenticate(),
        ),
        providers: [
          ChangeNotifierProvider(create: (_) => NotificationService())
        ]);
  }
}
