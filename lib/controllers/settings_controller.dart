import 'package:get/get.dart';
import 'package:shared_preferences.dart';

class SettingsController extends GetxController {
  final _prefs = Get.find<SharedPreferences>();

  // Timer Durations
  final pomodoroDuration = 25.obs;
  final shortBreakDuration = 5.obs;
  final longBreakDuration = 15.obs;

  // Goals
  final dailyGoal = 8.obs;
  final pomodorosUntilLongBreak = 4.obs;

  // Notifications
  final soundEnabled = true.obs;
  final notificationsEnabled = true.obs;

  // Auto Start
  final autoStartBreaks = false.obs;
  final autoStartPomodoros = false.obs;

  // Theme
  final theme = 'System'.obs;
  final colorScheme = 'Default'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    pomodoroDuration.value = _prefs.getInt('pomodoroDuration') ?? 25;
    shortBreakDuration.value = _prefs.getInt('shortBreakDuration') ?? 5;
    longBreakDuration.value = _prefs.getInt('longBreakDuration') ?? 15;
    dailyGoal.value = _prefs.getInt('dailyGoal') ?? 8;
    pomodorosUntilLongBreak.value = _prefs.getInt('pomodorosUntilLongBreak') ?? 4;
    soundEnabled.value = _prefs.getBool('soundEnabled') ?? true;
    notificationsEnabled.value = _prefs.getBool('notificationsEnabled') ?? true;
    autoStartBreaks.value = _prefs.getBool('autoStartBreaks') ?? false;
    autoStartPomodoros.value = _prefs.getBool('autoStartPomodoros') ?? false;
    theme.value = _prefs.getString('theme') ?? 'System';
    colorScheme.value = _prefs.getString('colorScheme') ?? 'Default';
  }

  // Timer Duration Setters
  void setPomodoroLength(int value) {
    pomodoroDuration.value = value;
    _prefs.setInt('pomodoroDuration', value);
  }

  void setShortBreakLength(int value) {
    shortBreakDuration.value = value;
    _prefs.setInt('shortBreakDuration', value);
  }

  void setLongBreakLength(int value) {
    longBreakDuration.value = value;
    _prefs.setInt('longBreakDuration', value);
  }

  // Goals Setters
  void setDailyGoal(int value) {
    dailyGoal.value = value;
    _prefs.setInt('dailyGoal', value);
  }

  void setPomodorosUntilLongBreak(int value) {
    pomodorosUntilLongBreak.value = value;
    _prefs.setInt('pomodorosUntilLongBreak', value);
  }

  // Notifications Setters
  void setSoundEnabled(bool value) {
    soundEnabled.value = value;
    _prefs.setBool('soundEnabled', value);
  }

  void setNotificationsEnabled(bool value) {
    notificationsEnabled.value = value;
    _prefs.setBool('notificationsEnabled', value);
  }

  // Auto Start Setters
  void setAutoStartBreaks(bool value) {
    autoStartBreaks.value = value;
    _prefs.setBool('autoStartBreaks', value);
  }

  void setAutoStartPomodoros(bool value) {
    autoStartPomodoros.value = value;
    _prefs.setBool('autoStartPomodoros', value);
  }

  // Theme Setters
  void setTheme(String? value) {
    if (value != null) {
      theme.value = value;
      _prefs.setString('theme', value);
      // Implement theme change logic
    }
  }

  void setColorScheme(String? value) {
    if (value != null) {
      colorScheme.value = value;
      _prefs.setString('colorScheme', value);
      // Implement color scheme change logic
    }
  }
}