import 'dart:async';
import 'package:flutter/material.dart';

class ProviderClass extends ChangeNotifier {
  Timer? _timer;
  int _remainingTime = 60;
  int get remainingTime => _remainingTime;
  // bool? _isTimerRemaining = false;
  bool get isTimerRunning => _remainingTime > 0;
  bool? _showSubServices = false;
  bool? get showSubServices => _showSubServices;

  String _selectedServiceId = '0';
  String get selectedServiceId => _selectedServiceId;

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

  showSubSerives(bool? value) {
    _showSubServices = value;
    notifyListeners();
  }

  chooseService(String id, int index) {
    _selectedServiceId = id;
    notifyListeners();
  }
}

class CombinedData {
  bool? isTimerRunning;
  int? remainingTime;
  CombinedData({this.isTimerRunning, this.remainingTime});
}
