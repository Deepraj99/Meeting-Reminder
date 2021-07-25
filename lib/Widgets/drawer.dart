import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meeting_reminder/Home/methods.dart';
import 'package:url_launcher/url_launcher.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            children: [
              Image.asset('assets/images/background.jpg'),
              Container(height: 250, color: Color(0xFF444974).withOpacity(.85)),
            ],
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("LogOut",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            onTap: () => logOut(context),
          ),
          ListTile(
            leading: Icon(Icons.cancel_rounded),
            title: Text("Cancle",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text("Contact Us",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            onTap: () => _launchURL,
          ),
        ],
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://www.linkedin.com/in/deepak-prajapati-08b8b3191/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
