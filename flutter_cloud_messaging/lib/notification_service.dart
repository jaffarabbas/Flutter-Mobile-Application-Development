import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initLocalNotifications(BuildContext context,RemoteMessage message) async {
    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializeSettings = InitializationSettings(
        android: androidSettings
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializeSettings,
      onDidReceiveNotificationResponse: (payload){

      }
    );
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("User granted");
    }else if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("User granted Provision Permission");
    }else{
      print("User Denied Permisssion");
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void firebaseMessagingInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message) {
      if(Platform.isAndroid){
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notifications',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        androidNotificationChannel.id.toString(),
        androidNotificationChannel.name.toString(),
        channelDescription: 'Test',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker'
    );
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );

    NotificationDetails details = NotificationDetails(
      android: androidNotificationDetails
    );
    Future.delayed(Duration.zero,(){
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          details);
    });
  }
}