import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        children: [
          // Timer Duration Settings
          _buildSection(
            title: 'Timer Durations',
            children: [
              _buildDurationSetting(
                label: 'Pomodoro Duration',
                value: controller.pomodoroDuration,
                onChanged: controller.setPomodoroLength,
                suffix: 'minutes',
              ),
              _buildDurationSetting(
                label: 'Short Break Duration',
                value: controller.shortBreakDuration,
                onChanged: controller.setShortBreakLength,
                suffix: 'minutes',
              ),
              _buildDurationSetting(
                label: 'Long Break Duration',
                value: controller.longBreakDuration,
                onChanged: controller.setLongBreakLength,
                suffix: 'minutes',
              ),
            ],
          ),

          // Goals Settings
          _buildSection(
            title: 'Goals',
            children: [
              _buildDurationSetting(
                label: 'Daily Pomodoro Goal',
                value: controller.dailyGoal,
                onChanged: controller.setDailyGoal,
                suffix: 'pomodoros',
                min: 1,
                max: 16,
              ),
              _buildDurationSetting(
                label: 'Long Break After',
                value: controller.pomodorosUntilLongBreak,
                onChanged: controller.setPomodorosUntilLongBreak,
                suffix: 'pomodoros',
                min: 2,
                max: 6,
              ),
            ],
          ),

          // Notifications Settings
          _buildSection(
            title: 'Notifications',
            children: [
              Obx(() => SwitchListTile(
                title: Text('Sound Notifications'),
                subtitle: Text('Play sound when timer completes'),
                value: controller.soundEnabled.value,
                onChanged: controller.setSoundEnabled,
              )),
              Obx(() => SwitchListTile(
                title: Text('Push Notifications'),
                subtitle: Text('Show notification when timer completes'),
                value: controller.notificationsEnabled.value,
                onChanged: controller.setNotificationsEnabled,
              )),
            ],
          ),

          // Auto Start Settings
          _buildSection(
            title: 'Auto Start',
            children: [
              Obx(() => SwitchListTile(
                title: Text('Auto Start Breaks'),
                subtitle: Text('Automatically start break timer'),
                value: controller.autoStartBreaks.value,
                onChanged: controller.setAutoStartBreaks,
              )),
              Obx(() => SwitchListTile(
                title: Text('Auto Start Pomodoros'),
                subtitle: Text('Automatically start pomodoro timer'),
                value: controller.autoStartPomodoros.value,
                onChanged: controller.setAutoStartPomodoros,
              )),
            ],
          ),

          // Theme Settings
          _buildSection(
            title: 'Theme',
            children: [
              ListTile(
                title: Text('App Theme'),
                trailing: Obx(() => DropdownButton<String>(
                  value: controller.theme.value,
                  items: ['Light', 'Dark', 'System'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: controller.setTheme,
                )),
              ),
              ListTile(
                title: Text('Color Scheme'),
                trailing: Obx(() => DropdownButton<String>(
                  value: controller.colorScheme.value,
                  items: ['Default', 'Forest', 'Ocean', 'Sunset'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: controller.setColorScheme,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        ...children,
        Divider(height: 1),
      ],
    );
  }

  Widget _buildDurationSetting({
    required String label,
    required int value,
    required Function(int) onChanged,
    required String suffix,
    int min = 1,
    int max = 60,
  }) {
    return ListTile(
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: value > min ? () => onChanged(value - 1) : null,
          ),
          Text('$value $suffix'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: value < max ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}