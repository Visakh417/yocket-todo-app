class TimeUtil {
  static String getTimeRemaining(int totalDuration, int completedDuration) {
    if (completedDuration >= totalDuration) {
      return "Completed";
    }
    int remainingTime = totalDuration - completedDuration;

    double convertedTime = remainingTime / 60;
    int minute = convertedTime.truncate();
    int seconds = ((convertedTime - convertedTime.truncate()) * 60).round();

    if (minute < 1) {
      return "${seconds}s remaining";
    }
    
    return "${minute}m  ${seconds}s remaining";
  }
}
