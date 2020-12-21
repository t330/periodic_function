import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flashlight/flashlight.dart';
import 'package:intl/intl.dart';

class MainModel extends ChangeNotifier {
  Timer _timer;
  int numberOfFlashes = 0;
  String timeOfFlash = '';
  List flashHistory = [];
  bool isStarting = false;
  //List flashHistory = List<String>.generate(10, (i) => "Item ${i + 1}");

  void initialFlashlight(duration) {
    flashlightSettings();
    _timer = Timer.periodic(
      Duration(seconds: duration),
      turnOnFlashlight,
    );
    isStarting = true;
    notifyListeners();
  }
  void flashlightSettings() async {
    Flashlight.lightOn();
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    var formattedTime = formatter.format(now);
    timeOfFlash = formattedTime;
    flashHistory.add(timeOfFlash);
    numberOfFlashes++;
    notifyListeners();
    print('フラッシュオン！');
    await new Future.delayed(new Duration(seconds: 1));
    Flashlight.lightOff();
    print('フラッシュオフ！');
  }
  void turnOnFlashlight(Timer timer) {
    flashlightSettings();
  }
  void cancelInitialFlashlight() {
    _timer.cancel();
    print('キャンセル!');
    isStarting = false;
    notifyListeners();
  }
}