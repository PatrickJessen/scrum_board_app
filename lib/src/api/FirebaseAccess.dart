
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FirebaseAccess
{

  void RequestPermission(String username) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized){
      await GetUserToken(username);
      print("User granted permission");
      return;
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User granted provisional permission");
      return;
    }
    print("User diddnt accept permission");
  }

  Future<String> GetUserToken(String username) async {
    await FirebaseMessaging.instance.getToken().then((value) {
      SaveToken(username, value);
      return value;
    });
  }

  void SaveToken(String username, String token) async {
    await FirebaseFirestore.instance.collection("UserTokens").doc(username).set({
      'token' : token,
    });
  }

  void SendPushNotification(String token, String body, String title) async {
    try
    {
      await http.post(Uri.parse('https://fcm.googleapis.com/semd'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization' : 'key=AAAA47BOqiI:APA91bE3ORXQ_hqzAWUl-nln1dU-dHWl3LS04-Gi2Lv6c3rseb1BafaM2-qt8RlvkIZWrRQ97Xi90tEPsse7qdvMhaYIlCGSNkmt6vRqjXe1UlmkQKjDMIOt5nC1IBcA7kF-PMd7WugZ'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "flutterproject-5dd44"
            },
            "to": token,
          },
        ));
    }
    catch (e) {
      print("Failed to send push notification");
    }
  }
}