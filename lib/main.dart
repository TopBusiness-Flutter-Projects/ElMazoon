import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elmazoon/injector.dart' as injector;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:screen_capture_event/screen_capture_event.dart';
import 'dart:async';

import 'app.dart';
import 'app_bloc_observer.dart';
import 'core/models/user_model.dart';
import 'core/notification/notification.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/restart_app_class.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PushNotificationService.instance.initialise();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE).then((value) {

    print('************************************************');
    print(value);
    print('************************************************');

  });

  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  AppColors.getPrimaryColor();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  alert: true,
  badge: true,
  sound: true,
  );
  await pushNotificationService!.initialise();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  alert: true,
  badge: true,
  sound: true,
  );
  await injector.setup();
  Bloc.observer = AppBlocObserver();

  runApp(
  EasyLocalization(
  supportedLocales: [Locale('ar', ''), Locale('en', '')],
  path: 'assets/lang',
  saveLocale: true,
  startLocale: Locale('ar', ''),
  fallbackLocale: Locale('ar', ''),
  child: HotRestartController(child: const Elmazoon()),
  ),
  );


}

PushNotificationService? pushNotificationService = PushNotificationService();

final locator = GetIt.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

late AndroidNotificationChannel channel;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Handling a background message:");

  AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
      onDidReceiveLocalNotification: await ondidnotification);
  final LinuxInitializationSettings initializationSettingsLinux =
  LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: notificationTapBackground,
  );

  if (message.data.isNotEmpty) {
    checkData(message);

    print("Handling a background message: ${message.data}");
  }
}

void showNotification(RemoteMessage message) async {
  String paylod = "";
  if (message.data["note_type"] == "chat") {
    paylod = message.data['room'] + message.data['note_type'];
  } else {
    message.data['note_type'];
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );
  UserModel userModel = await Preferences.instance.getUserModel();

  await flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      payload: paylod,
      NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              icon: '@mipmap/ic_launcher')));
}

void checkData(RemoteMessage message) {
  if (message.data['note_type'].toString().contains("chat")) {
    showNotification(message);
  } else {
    showNotification(message);
  }
}

Future ondidnotification(int id, String? title, String? body,
    String? payload) async {
  print("object");
  if (payload!.contains("chat")) {} else if (payload == "service_request") {}
}

Future notificationTapBackground(NotificationResponse details) async {
  print('notification payload: ${details.payload}');
  if (details.payload!.contains("chat")) {}
}

Future onNotification(String payload) async {
  print(payload);
  if (payload.contains("chat")) {}
}

void _runWhileAppIsTerminated() async {
  await flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails()
      .then((value) =>
  {
    if (value != null &&
        value.notificationResponse != null &&
        value.notificationResponse!.payload!.isNotEmpty)
      {}
  });
}



