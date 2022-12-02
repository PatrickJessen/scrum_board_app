import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

/**
 * This class access the Firebase API/Database
 * used to send push notifications when a user
 * changed/created or deleted a task and if
 * user has started a new sprint
 */
class FirebaseAccess {
  static String mToken = "";
  static AndroidNotificationChannel channel;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static String userToken = "";

  static void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  static void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  static Future<void> RequestPermission(String username) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      GetToken();
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("UserTokens")
          .doc(username)
          .get();
      userToken = snap["token"];
      print("got token: $userToken");
      //await SaveToken(username);
      print("User granted permission");
      return;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
      return;
    }
    print("User diddnt accept permission");
  }

  static void GetToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mToken = token;
      print("getToken() $mToken");
      SaveToken(token);
    });
  }

  static void SaveToken(String username) async {
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(username)
        .set({
      'token': mToken,
    });
    print("Token saved");
  }

  static void SendPushNotification(String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA47BOqiI:APA91bE3ORXQ_hqzAWUl-nln1dU-dHWl3LS04-Gi2Lv6c3rseb1BafaM2-qt8RlvkIZWrRQ97Xi90tEPsse7qdvMhaYIlCGSNkmt6vRqjXe1UlmkQKjDMIOt5nC1IBcA7kF-PMd7WugZ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": userToken,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }
}
