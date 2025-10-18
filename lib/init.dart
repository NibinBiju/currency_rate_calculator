import 'package:currency_rate_calculator/firebase_options.dart';
import 'package:currency_rate_calculator/get_service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void init() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase initialize
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //initialize Dependecies
  initializeDependecies();
}
