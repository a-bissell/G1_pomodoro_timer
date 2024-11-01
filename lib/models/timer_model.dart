enum TimerType { pomodoro, shortBreak, longBreak }

class TimerModel {
  final TimerType type;
  final int durationMinutes;
  final DateTime? startTime;
  final bool isRunning;

  TimerModel({
    required this.type,
    required this.durationMinutes,
    this.startTime,
    this.isRunning = false,
  });

  TimerModel copyWith({
    TimerType? type,
    int? durationMinutes,
    DateTime? startTime,
    bool? isRunning,
  }) {
    return TimerModel(
      type: type ?? this.type,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      startTime: startTime ?? this.startTime,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}