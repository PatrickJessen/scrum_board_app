import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scrum_board_app/Screens/BoardScreen.dart';
import 'package:scrum_board_app/src/Managers/LoginManager.dart';

import '../src/User.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginManager login;
  String username = "";
  String password = "";
  String errorMsg = "";

  @override
  void initState() {
    super.initState();
    login = LoginManager();
    //_editingController = TextEditingController(text: task.title);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromARGB(120, 145, 145, 145),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                errorMsg,
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 0, 0), fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              username = value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text.rich(
                                TextSpan(children: <InlineSpan>[
                                  WidgetSpan(child: Text("Username")),
                                ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text.rich(
                                TextSpan(children: <InlineSpan>[
                                  WidgetSpan(child: Text("Password")),
                                ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      final data =
                                          await login.Login(username, password);
                                      setState(() => User.currentUser = data);

                                      if (User.currentUser != null) {
                                        errorMsg = "";
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BoardWidget()));
                                      } else {
                                        setState(() {
                                          errorMsg =
                                              "Username and password did not match!";
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
