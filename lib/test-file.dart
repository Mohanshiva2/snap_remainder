import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  //  initialize
  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("ic_launcher");

    IOSInitializationSettings iosInitializationSettings =
    IOSInitializationSettings();

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  }

  Future scheduledNotification() async {
    var scheduleNotificationDateTime = DateTime.now().add(Duration(seconds: 3));

    // var interval = RepeatInterval.everyMinute;
    var bigPicture = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('ic_launcher'),
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
      contentTitle: 'Streak Remainder Notification',
      summaryText: 'This is Remainder notification',
      htmlFormatContent: true,
      htmlFormatContentTitle: true,
    );

    var android = AndroidNotificationDetails('id', 'channel',
        styleInformation: bigPicture);

    var platform = NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.schedule(
      0,
      "Update Your Snap",
      'its Time to update your Snapchat Streak',
      scheduleNotificationDateTime,
      platform,
    );
  }

  Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height * 1.0,
            width: width * 1.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            // child: Lottie.asset('assets/rocket.json', fit: BoxFit.fill),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.5,
                  width: width * 1.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Lottie.asset('assets/notification-animation.json',
                        fit: BoxFit.fitHeight, height: height * 1.0),
                  ),
                ),
                SizedBox(
                  height: height * 0.2,
                ),
                SizedBox(
                  width: width * 1.0,
                  height: height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            scheduledNotification();
                            addSnackBar(context);
                            // print('iam pressed');
                          });
                        },
                        child: Container(
                          width: width * 0.4,
                          height: height * 0.08,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigoAccent,
                                Colors.blue.shade900
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black87,
                                offset: Offset(8.0, 8.0),
                                blurRadius: 1.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'SET \n'
                                  'REMAINDER',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 5,
                                fontSize: height * 0.013,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.09,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            cancelNotification();
                          });
                        },
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              cancelSnackBar(context);
                              cancelNotification();
                            });
                          },
                          child: Container(
                            width: width * 0.4,
                            height: height * 0.08,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.indigoAccent,
                                  Colors.blue.shade900,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black87,
                                  offset: Offset(8.0, 8.0),
                                  blurRadius: 1.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'CANCEL',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                  letterSpacing: 5,
                                  fontSize: height * 0.013,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addSnackBar(BuildContext context) =>
      Flushbar(
        shouldIconPulse: false,
        messageColor: Colors.black,
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.all(30),
        title: 'Snap Remainder',
        message: 'Successfully Added',
        duration: Duration(seconds: 1),
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.add_task,
          size: 50,
        ),
        borderRadius: BorderRadius.circular(12),
        backgroundGradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.purple.shade400, Colors.cyanAccent.shade700],
        ),
      )
        ..show(context);

  void cancelSnackBar(BuildContext context) =>
      Flushbar(
        shouldIconPulse: false,
        messageColor: Colors.black,
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.all(30),
        title: 'Snap Remainder',
        message: 'Remainder Cancelled',
        duration: Duration(seconds: 1),
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.cancel,
          size: 50,
        ),
        borderRadius: BorderRadius.circular(12),
        backgroundGradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.purple.shade400, Colors.cyanAccent.shade700],
        ),
      )
        ..show(context);
}
