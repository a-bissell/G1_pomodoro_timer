import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/timer_controller.dart';
import 'views/timer_page.dart';
import 'package:shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
  Get.put(SettingsController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TimerPage(),
    );
  }
}