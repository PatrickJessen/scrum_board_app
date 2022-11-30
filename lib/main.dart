import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/BoardScreen.dart';
import 'Screens/LoginScreen.dart';

/*
Platform  Firebase App Id
web       1:977915521570:web:86fb9d707757bec623787b
android   1:977915521570:android:a000d399ef3360d523787b
ios       1:977915521570:ios:12ee6d7ff1b551c623787b
macos     1:977915521570:ios:12ee6d7ff1b551c623787b
 */

class MyHttpOverrides extends HttpOverrides {
@override
HttpClient createHttpClient(SecurityContext context) {
return super.createHttpClient(context)
  ..badCertificateCallback =
      (X509Certificate cert, String host, int port) => true; }}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
