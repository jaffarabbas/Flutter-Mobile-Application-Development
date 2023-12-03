import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_messaging/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.requestNotificationPermission();

    notificationService.isTokenRefresh();
    notificationService.firebaseMessagingInit(context);
    notificationService.getDeviceToken().then((value){
      print("Token");
      print(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter FCM'),
      ),
      body: Container(
        child: Text('Test'),
      ),
    );
  }
}
