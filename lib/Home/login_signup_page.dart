import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meeting_reminder/Home/homePage.dart';
import 'package:meeting_reminder/Home/methods.dart';
import 'package:meeting_reminder/Widgets/colors.dart';
import 'package:meeting_reminder/Widgets/toastMsg.dart';

class LoginSignup extends StatefulWidget {
  LoginSignup({Key? key}) : super(key: key);

  @override
  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  bool isSignUpScreen = true;
  bool isMale = true;
  bool isRememberMe = false;

  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 90,
                  left: 20,
                ),
                color: Color(0xFF444974).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Welcome ",
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2,
                          color: Colors.yellow[700],
                        ),
                        children: [
                          TextSpan(
                            text: isSignUpScreen
                                ? "to Meeting Reminder,"
                                : "Back,",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      isSignUpScreen
                          ? "Signup to continue"
                          : "Login to continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildButtomHalfContainer(true),
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.bounceInOut,
            top: isSignUpScreen ? 230 : 250,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignUpScreen ? 325 : 270,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUpScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSignUpScreen ? textColor1 : activeColor,
                                ),
                              ),
                              if (!isSignUpScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUpScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSignUpScreen ? activeColor : textColor1,
                                ),
                              ),
                              if (isSignUpScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isSignUpScreen) buildSignupSection(),
                    if (!isSignUpScreen) buildLoginSection(),
                  ],
                ),
              ),
            ),
          ),
          buildButtomHalfContainer(false),
          Positioned(
            top: MediaQuery.of(context).size.height - 100,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Text(isSignUpScreen ? "Or Signup with" : "Or Login with"),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  child: buildTextButton("Google", googleColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildLoginSection() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          buildTextField(Icons.mail_outline, "Email", false, true),
          buildTextField(Icons.lock_outline, "Password", true, false),
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          buildTextField(Icons.person_outline, "User name", false, false),
          buildTextField(Icons.email_outlined, "Email", false, true),
          buildTextField(Icons.lock_outline, "Password", true, false),
        ],
      ),
    );
  }

  Widget buildTextButton(String title, Color backgroundColor) {
    return Container(
      child: _isLoggedIn
          ? Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                    _googleSignIn.signOut().then((value) {
                      setState(() {
                        _isLoggedIn = false;
                      });
                    }).catchError((e) {});
                  },
                  child: Text("LogOut"),
                ),
              ],
            )
          : TextButton(
              onPressed: () async {
                await _googleSignIn.signIn().then((userData) {
                  setState(() {
                    _isLoggedIn = true;
                    _userObj = userData!;
                  });
                }).catchError((e) {
                  print(e);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                side: BorderSide(width: 1, color: Colors.grey),
                minimumSize: Size(170, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                primary: Colors.white,
                backgroundColor: backgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildButtomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignUpScreen ? 510 : 470,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (isSignUpScreen) {
              if (_name.text.isEmpty) {
                showToastName(context);
              } else if (!_email.text.contains('@')) {
                showToastEmail(context);
              } else if (_password.text.length < 6) {
                showToastPassword(context);
              } else if (_name.text.isNotEmpty &&
                  _email.text.isNotEmpty &&
                  _password.text.isNotEmpty) {
                setState(() {
                  isLoading = true;
                });
                createAccount(_name.text, _email.text, _password.text)
                    .then((user) {
                  if (user != null) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                    print("Login Sucessfully!");
                  } else {
                    showToast(context);
                    print("Login Failed!");
                  }
                });
              } else {
                print("Please! enter fields");
              }
            } else {
              if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                setState(() {
                  isLoading = true;
                });
                logIn(_email.text, _password.text).then((user) {
                  if (user != null) {
                    print("Login Sucessfully!");
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  } else {
                    showToast(context);
                    print("Login Failed!");
                    setState(() {
                      isLoading = false;
                    });
                  }
                });
              } else {
                print("Please! fill the data correctly");
              }
            }
          },
          child: Container(
            height: 90,
            width: 90,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  if (showShadow)
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: Offset(0, 1),
                    )
                ]),
            child: !showShadow
                ? Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange.shade200, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  )
                : Center(),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            if (hintText == 'User name') {
              _name.text = value;
            } else if (hintText == 'Email') {
              _email.text = value;
            } else {
              _password.text = value;
            }
          });
        },
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor1),
            borderRadius: BorderRadius.all(
              Radius.circular(35.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor1),
            borderRadius: BorderRadius.all(
              Radius.circular(35.0),
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 16, color: textColor1),
        ),
      ),
    );
  }
}
