import 'package:flutter/cupertino.dart';

class DashboardProvider extends ChangeNotifier {
  String _selectedTime = 'Daily';
  String get selectedTime => _selectedTime;
  final List<String> _time = [
    'Daily',
    'Weekly',
    'Monthly',
  ];
  List<String> get time => _time;

  void setTime(String value) {
    _selectedTime = value;
    notifyListeners();
  }
}
