import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/data/location_notifier.dart';
import 'package:weather_app/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LocationNotifier()),
        ChangeNotifierProvider(builder: (_) => WeatherBloc()),

      ],
      child: MaterialApp(
        title: 'State Management',
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
        ),
        home: HomePage(),
      ),
    );
  }
}
