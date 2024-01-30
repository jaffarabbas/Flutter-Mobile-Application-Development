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
        title: const Text('Flutter FCM'),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(2),
            width: 200,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 1,
                  ),
                ]
            ),
            child: const Center(
              child: Text('Test',style: TextStyle(fontSize: 20),),
            )
        ),
      )
    );
  }
}
