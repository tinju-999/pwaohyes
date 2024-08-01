// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pwaohyes/model/bookingdatemodel.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

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

  void changeServiceTime(TimeOfDay value) {
    DateTime selectedDate = Initializer.selectedServiceDate;
    Initializer.selectedServiceTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        value.hour,
        value.minute,
        0,
        0,
        0);
    Initializer.bookingTimeSuggestions.forEach((e) => e.isSelected = false);
    if (!Initializer.bookingTimeSuggestions.any((e) {
      if (e.date != null) {
        if (e.date!.hour == value.hour && e.date!.minute == value.minute) {
          e.isSelected = true;
          return true;
        } else {
          e.isSelected = false;
          return false;
        }
      } else {
        return false;
      }
    })) {
      Helper.showLog("haa");

      Initializer.bookingTimeSuggestions.last = BookingDateTimeModel(
        isSelected: true,
        date: Initializer.selectedServiceTime,
        label: Helper.setDateFormat(
            dateTime: Initializer.selectedServiceTime, format: "hh:mm a"),
      );
    }
    notifyListeners();
  }

  void selectServiceDate(DateTime? value) {
    Helper.showLog("Service date selected");
    Initializer.bookingDateSuggestions.forEach((e) => e.isSelected = false);
    var today = Initializer.bookingDateSuggestions[0].date;
    var tomorrow = Initializer.bookingDateSuggestions[1].date;
    if (isDatesEqual(value!, today)) {
      Initializer.bookingDateSuggestions[0].isSelected = true;
    } else if (isDatesEqual(value, tomorrow)) {
      Initializer.bookingDateSuggestions[1].isSelected = true;
    } else {
      Initializer.bookingDateSuggestions[2].isSelected = true;
    }
    Initializer.selectedServiceDate = value;
    Helper.setTimings(Initializer.selectedServiceDate);
    notifyListeners();
  }

  bool isDatesEqual(DateTime value, DateTime? date) =>
      value.year == date!.year &&
      value.month == date.month &&
      value.day == date.day;

  selectServiceDateIndex(int index) {
    Initializer.bookingDateSuggestions.forEach((e) => e.isSelected = false);
    Initializer.bookingDateSuggestions[index].isSelected = true;
    notifyListeners();
  }

  selectServiceTimeIndex(int index) {
    Initializer.bookingTimeSuggestions.forEach((e) => e.isSelected = false);
    Initializer.bookingTimeSuggestions[index].isSelected = true;
    notifyListeners();
  }
}

class CombinedData {
  bool? isTimerRunning;
  int? remainingTime;
  CombinedData({this.isTimerRunning, this.remainingTime});
}
