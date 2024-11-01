import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';

class TimerPage extends GetView<TimerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
              _formatTime(controller.secondsRemaining),
              style: Theme.of(context).textTheme.displayLarge,
            )),
            SizedBox(height: 32),
            Row(
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
                )),
                SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: controller.resetTimer,
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
            SizedBox(height: 32),
            Obx(() => Text(
              'Completed Cycles: ${controller.cycles}',
              style: Theme.of(context).textTheme.titleLarge,
            )),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}