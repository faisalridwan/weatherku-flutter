import 'package:flutter/material.dart';import 'package:weather_app/prefs/preferences.dart';class LocationNotifier  with ChangeNotifier {  LocationNotifier(String lokasiNow);  String _locNow = 'Bandung';  String get getLoc => _locNow;  void setLoc(String locData) async {    _locNow = locData;    notifyListeners();  }}