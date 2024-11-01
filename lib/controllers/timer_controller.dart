import 'dart:async';
import 'package:get/get.dart';
import '../models/timer_model.dart';
import '../services/notification_service.dart';

class TimerController extends GetxController {
  final _timer = TimerModel(
    type: TimerType.pomodoro,
    durationMinutes: 25,
  ).obs;
  
  Timer? _countdownTimer;
  final _secondsRemaining = 0.obs;
  final _cycles = 0.obs;

  TimerModel get timer => _timer.value;
  int get secondsRemaining => _secondsRemaining.value;
  int get cycles => _cycles.value;

  @override
  void onInit() {
    super.onInit();
    NotificationService.initialize();
  }

  void startTimer() {
    if (!timer.isRunning) {
      _timer.value = timer.copyWith(
        isRunning: true,
        startTime: DateTime.now(),
      );
      
      _secondsRemaining.value = timer.durationMinutes * 60;
      _startCountdown();
    }
  }

  void pauseTimer() {
    _countdownTimer?.cancel();
    _timer.value = timer.copyWith(isRunning: false);
  }

  void resetTimer() {
    _countdownTimer?.cancel();
    _secondsRemaining.value = timer.durationMinutes * 60;
    _timer.value = timer.copyWith(
      isRunning: false,
      startTime: null,
    );
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining.value > 0) {
        _secondsRemaining.value--;
      } else {
        _onTimerComplete();
      }
    });
  }

  void _onTimerComplete() {
    _countdownTimer?.cancel();
    NotificationService.showNotification(
      'Timer Complete!',
      'Time to ${timer.type == TimerType.pomodoro ? "take a break" : "focus"}!',
    );
    
    if (timer.type == TimerType.pomodoro) {
      _cycles.value++;
    }
    
    _switchToNextTimer();
  }

  void _switchToNextTimer() {
    switch (timer.type) {
      case TimerType.pomodoro:
        _timer.value = TimerModel(
          type: _cycles.value % 4 == 0 ? TimerType.longBreak : TimerType.shortBreak,
          durationMinutes: _cycles.value % 4 == 0 ? 15 : 5,
        );
        break;
      case TimerType.shortBreak:
      case TimerType.longBreak:
        _timer.value = TimerModel(
          type: TimerType.pomodoro,
          durationMinutes: 25,
        );
        break;
    }
    _secondsRemaining.value = _timer.value.durationMinutes * 60;
  }
}