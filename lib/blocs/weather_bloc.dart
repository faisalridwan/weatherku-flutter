import 'package:dio/dio.dart';import 'package:flutter/foundation.dart';import 'package:weather_app/isolate_task/get_weather.dart';import 'package:weather_app/isolate_task/worker/worker.dart';import 'package:weather_app/model/weather_model.dart';class WeatherBloc extends ChangeNotifier {  WeatherModel allWeather;  bool loading = false;  Future getTodoWeather() async {    final dio = Dio();    var todoTask = GetWeather(dio: dio);    final worker = Worker(poolSize: 2);    loading = true;    notifyListeners();    allWeather = (await worker.handle(todoTask)) as WeatherModel;    loading = false;    notifyListeners();  }}