import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elmazoon/injector.dart' as injector;
import 'dart:async';

import 'app.dart';
import 'app_bloc_observer.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await injector.setup();
  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      path: 'lang',
      saveLocale: false,
      startLocale: const Locale('ar', ''),
      fallbackLocale: const Locale('ar', ''),
      child: const Elmazoon(),
    ),
  );
}
