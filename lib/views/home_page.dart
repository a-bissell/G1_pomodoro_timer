import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';

class HomePage extends GetView<TimerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Get.toNamed('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer Type Selector
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTypeButton('Pomodoro', TimerType.pomodoro),
                  _buildTypeButton('Short Break', TimerType.shortBreak),
                  _buildTypeButton('Long Break', TimerType.longBreak),
                ],
              )),
            ),

            // Timer Display
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Timer Circle
                    Obx(() => Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 250,
                          child: CircularProgressIndicator(
                            value: controller.progress,
                            strokeWidth: 8,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getColorForType(controller.timer.type),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.timeDisplay,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Text(
                              controller.timer.type.toString().split('.').last,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    )),

                    // Control Buttons
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => FloatingActionButton(
                            onPressed: controller.timer.isRunning 
                              ? controller.pauseTimer 
                              : controller.startTimer,
                            child: Icon(
                              controller.timer.isRunning 
                                ? Icons.pause 
                                : Icons.play_arrow,
                            ),
                            backgroundColor: _getColorForType(controller.timer.type),
                          )),
                          SizedBox(width: 20),
                          FloatingActionButton(
                            onPressed: controller.resetTimer,
                            child: Icon(Icons.refresh),
                            backgroundColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Statistics
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Obx(() => Text(
                    'Completed Pomodoros: ${controller.completedPomodoros}',
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
                  SizedBox(height: 8),
                  Obx(() => Text(
                    'Daily Goal: ${controller.completedPomodoros}/8',
                    style: Theme.of(context).textTheme.titleSmall,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(String label, TimerType type) {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () => controller.changeTimerType(type),
        style: TextButton.styleFrom(
          backgroundColor: controller.timer.type == type 
            ? _getColorForType(type) 
            : Colors.transparent,
          foregroundColor: controller.timer.type == type 
            ? Colors.white 
            : _getColorForType(type),
        ),
        child: Text(label),
      ),
    ));
  }

  Color _getColorForType(TimerType type) {
    switch (type) {
      case TimerType.pomodoro:
        return Colors.red;
      case TimerType.shortBreak:
        return Colors.green;
      case TimerType.longBreak:
        return Colors.blue;
    }
  }
}