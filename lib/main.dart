import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elmazoon/injector.dart' as injector;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:screen_capture_event/screen_capture_event.dart';
import 'dart:async';

import 'app.dart';
import 'app_bloc_observer.dart';
import 'core/notification/notification.dart';
import 'core/utils/restart_app_class.dart';
import 'firebase_options.dart';

// import 'firebase_options.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

 await PushNotificationService.instance.initialise();

  print('ooooooooooooooooooo');
  print("Handling a background message:");

  if (message.data.isNotEmpty) {
    PushNotificationService.instance.checkData(message);
    print("Handling a background message: ${message.data}");
  }
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PushNotificationService.instance.initialise();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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



