import 'dart:async';

import 'package:flutter/material.dart';

class ProviderClass extends ChangeNotifier {
  Timer? _timer;
  int _remainingTime = 60;
  int get remainingTime => _remainingTime;
  // bool? _isTimerRemaining = false;
  bool get isTimerRunning => _remainingTime > 0;

  CombinedData get combineData => CombinedData(
      remainingTime: _remainingTime, isTimerRunning: isTimerRunning);

  startTimer() {
    _remainingTime = 60;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _timer!.cancel();
        notifyListeners();
      }
    });
  }

  resetTimer() {
    _timer!.cancel();
    startTimer();
  }
}

class CombinedData {
  bool? isTimerRunning;
  int? remainingTime;
  CombinedData({this.isTimerRunning, this.remainingTime});
}
