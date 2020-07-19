import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer_bloc.dart';
import 'package:flutter_app/screens/home/userprofile.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_app/screens/home/findpeople.dart';

class NotificationsScreen extends StatefulWidget with DrawerStates{

  _LocalNotifications createState() => _LocalNotifications();
}

class _LocalNotifications extends State<NotificationsScreen> {

  FlutterLocalNotificationsPlugin plugin = new FlutterLocalNotificationsPlugin();
  var initilizationSettingsAndroid;
  var initilizationSettingsIOS;
  var initilizationSettings;

  void _shownotification() async {
    await timetable();
  }

  Future<void> _demoNotification() async{
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id', 'your channel name' , 'you channel description',
    importance: Importance.Max,
    priority: Priority.High,
    ticker: 'test ticker',);

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSChannelSpecifics);
    await plugin.show(0, 'Upcoming Class', 'A message from time table notifier', platformChannelSpecifics , payload: 'testpayload');
  }

  @override
  void initState() { 
    super.initState();
    initilizationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    initilizationSettingsIOS = new IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initilizationSettings = new InitializationSettings(initilizationSettingsAndroid, initilizationSettingsIOS);
    plugin.initialize(initilizationSettings,onSelectNotification: onSelectNotification);

  }

  Future onSelectNotification(String payload) async {
    if (payload != null){
      debugPrint('Notification Payload : $payload');
    }
    await Navigator.push(context, new MaterialPageRoute (builder: (context) => new UserProfileScreen()));
  }

  Future onDidReceiveLocalNotification(int id , String title , String body , String payload) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) =>CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async{
              Navigator.of(context,rootNavigator: true).pop();
              await Navigator.push(context,MaterialPageRoute(builder: (context)=>UserProfileScreen()));
            },
          )
        ]
      ));
  }

   //  @override
  Widget build(BuildContext context) => Padding(
     padding: EdgeInsets.only(top: 10,left: 70,right: 70),
    child: ListView(
      children: <Widget>[
        RaisedButton(
       elevation:5.0,
          textColor: Colors.white,
           color: Colors.blue,
           shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.grey),
),
          child: Text('Enable Notifications'),
          onPressed: _shownotification
          
          )
      ],
      )
  );
}

 Future<void> FriendReqNotification() async{

   FlutterLocalNotificationsPlugin plugin = new FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id', 'your channel name' , 'you channel description',
    importance: Importance.Max,
    priority: Priority.High,
    ticker: 'test ticker',);

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSChannelSpecifics);
    await plugin.show(0, 'Send Request', 'Your Request has been sent.', platformChannelSpecifics , payload: 'testpayload');
  }

   Future<void> CancelReqNotification() async{

   FlutterLocalNotificationsPlugin plugin = new FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id', 'your channel name' , 'you channel description',
    importance: Importance.Max,
    priority: Priority.High,
    ticker: 'test ticker',);

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSChannelSpecifics);
    await plugin.show(0, 'Cancel Request', 'Your Request has been cancelled.', platformChannelSpecifics , payload: 'testpayload');
  }

  Future<void> timetable() async{

 FlutterLocalNotificationsPlugin plugin = new FlutterLocalNotificationsPlugin();
  
String groupKey = 'com.android.example.WORK_EMAIL';
String groupChannelId = 'grouped channel id';
String groupChannelName = 'grouped channel name';
String groupChannelDescription = 'grouped channel description';

AndroidNotificationDetails firstNotificationAndroidSpecifics =
    new AndroidNotificationDetails(
        groupChannelId, groupChannelName, groupChannelDescription,
        importance: Importance.Max,
        priority: Priority.High,
        groupKey: groupKey);
NotificationDetails firstNotificationPlatformSpecifics =
    new NotificationDetails(firstNotificationAndroidSpecifics, null);

var time1 = new Time(23,48,0);  
await plugin.showWeeklyAtDayAndTime(1, 'Time Table Notifier',
    'Computer Networks Lab in Lab4 in 10 minutes.', 
    Day.Monday,
    time1,
    firstNotificationPlatformSpecifics
    );

AndroidNotificationDetails secondNotificationAndroidSpecifics =
    new AndroidNotificationDetails(
        groupChannelId, groupChannelName, groupChannelDescription,
        importance: Importance.Max,
        priority: Priority.High,
        groupKey: groupKey);
NotificationDetails secondNotificationPlatformSpecifics =
    new NotificationDetails(secondNotificationAndroidSpecifics, null);

var time2 = new Time(23,49,0);  
await plugin.showWeeklyAtDayAndTime(2, 'Time Table Notifier',
    'Project Demo is going on .', 
    Day.Monday,
    time2,
    secondNotificationPlatformSpecifics
    );


AndroidNotificationDetails thirdNotificationAndroidSpecifics =
    new AndroidNotificationDetails(
        groupChannelId, groupChannelName, groupChannelDescription,
        importance: Importance.Max,
        priority: Priority.High,
        groupKey: groupKey);
NotificationDetails thirdNotificationPlatformSpecifics =
    new NotificationDetails(thirdNotificationAndroidSpecifics, null);

var time3 = new Time(10,25,0);  
await plugin.showWeeklyAtDayAndTime(3, 'Test Notification for demo',
    'Here comes the notification .', 
    Day.Wednesday,
    time3,
    thirdNotificationPlatformSpecifics
    );

  }