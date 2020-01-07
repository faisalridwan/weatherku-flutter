import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:intl/intl.dart';import 'package:provider/provider.dart';import 'package:weather_app/blocs/weather_bloc.dart';import 'package:weather_app/data/location_notifier.dart';import 'package:weather_app/model/weather_model.dart';import 'package:weather_app/pages/detail_page.dart';import 'package:weather_app/pages/setting_page.dart';import 'package:weather_app/prefs/preferences.dart';class HomePage extends StatefulWidget {  @override  _HomePageState createState() => _HomePageState();}class _HomePageState extends State<HomePage> {  String locationShared = '';  String textData = '';  @override  void initState() {    Provider.of<WeatherBloc>(context, listen: false).getTodoWeather();  }  @override  Widget build(BuildContext context) {    final locationNotifier = Provider.of<LocationNotifier>(context);    return Scaffold(      appBar: AppBar(        backgroundColor: Colors.blueAccent,        title: Text("WeatherKu"),        actions: <Widget>[          Row(            children: <Widget>[              Container(                  margin: EdgeInsets.only(right: 30),                  child: Text( locationNotifier.getLoc.toString(),                    style: TextStyle(fontSize: 19),                  )),              Container(                margin: EdgeInsets.only(right: 20),                child: PopupMenuButton<int>(                  onSelected: (value) {                    print('ONSELEC = $value');                    Navigator.of(context).push(                      MaterialPageRoute(                        builder: (BuildContext context) => SettingPage(),                      ),                    );                  },                  child: Icon(                    Icons.more_vert,                    color: Colors.white,                  ),                  itemBuilder: (context) => [                    PopupMenuItem(                      value: 1,                      child: Text('Setting'),                    ),                  ],                ),              ),            ],          ),        ],      ),      body: Consumer<WeatherBloc>(        builder: (BuildContext context, WeatherBloc allWeather, Widget child) {          WeatherModel weather;          if (allWeather.loading) {            return Center(child: CircularProgressIndicator());          } else {            if (allWeather.allWeather != null) {              weather = allWeather.allWeather;            }          }          return HeaderSliverAppBar(weather);        },      ),    );  }  Widget HeaderSliverAppBar(WeatherModel weather) {    return CustomScrollView(      slivers: <Widget>[        SliverAppBar(          backgroundColor: Colors.blue,          expandedHeight: 250.0,          flexibleSpace: FlexibleSpaceBar(            centerTitle: true,            background: Container(              height: 300,              child: Row(                children: <Widget>[                  Container(                    height: 250,                    child: Column(                      crossAxisAlignment: CrossAxisAlignment.start,                      children: <Widget>[                        Container(                          margin:                              EdgeInsets.only(left: 30, bottom: 10, top: 25),                          child: Text(                            'Today, ${TodayUnix(weather.list[0].dt)}',                            style: TextStyle(                                color: Colors.white,                                fontSize: 25,                                fontWeight: FontWeight.bold),                          ),                        ),                        Container(                          margin: EdgeInsets.only(left: 50, top: 20),                          child: Text('${weather.list[0].temp.max} ℃',                              style: TextStyle(                                  color: Colors.white,                                  fontSize: 50,                                  fontWeight: FontWeight.bold)),                        ),                        Container(                          margin: EdgeInsets.only(left: 50, top: 20),                          child: Text('${weather.list[0].temp.min} ℃',                              style: TextStyle(                                  color: Colors.white,                                  fontSize: 30,                                  fontWeight: FontWeight.bold)),                        ),                      ],                    ),                  ),                  Container(                    margin: EdgeInsets.only(left: 35),                    height: 250,                    child: Column(                      children: <Widget>[                        CloudIconCheck(weather.list[0].temp.day, 0),                        CloudTextCheck(weather.list[0].temp.day, 0)                      ],                    ),                  )                ],              ),            ),          ),        ),        SliverList(          delegate: SliverChildBuilderDelegate(            (BuildContext context, int index) {              return Container(                height: 100,                child: InkWell(                  onTap: () {                    Navigator.of(context).push(                      MaterialPageRoute(                        builder: (_) => DetailPage(                          weather: weather.list[index+1],                        ),                      ),                    );                  },                  child: Container(                    margin: EdgeInsets.only(left: 5, right: 5),                    child: Card(                      elevation: 5,                      shape: RoundedRectangleBorder(                        borderRadius: BorderRadius.all(Radius.circular(10)),                      ),                      child: Row(                        children: <Widget>[                          CloudIconCheck(weather.list[index + 1].temp.day, 1),                          Column(                            mainAxisAlignment: MainAxisAlignment.center,                            crossAxisAlignment: CrossAxisAlignment.start,                            children: <Widget>[                              Container(                                margin: EdgeInsets.only(left: 30),                                child: Text(                                  DateUnix(weather.list[index + 1].dt),                                  style: TextStyle(                                      fontWeight: FontWeight.bold,                                      fontSize: 20),                                ),                              ),                              CloudTextCheck(                                  weather.list[index + 1].temp.day, 1)                            ],                          ),                          Container(                              margin: EdgeInsets.only(left: 25),                              child: Column(                                mainAxisAlignment: MainAxisAlignment.center,                                children: <Widget>[                                  Container(                                    margin: EdgeInsets.only(bottom: 5),                                    child: Text(                                      '${weather.list[index + 1].temp.max.toString()} ℃',                                      style: TextStyle(                                          fontSize: 30,                                          fontWeight: FontWeight.bold),                                    ),                                  ),                                  Container(                                    child: Text(                                        '${weather.list[index + 1].temp.min} ℃'),                                  ),                                ],                              ))                        ],                      ),                    ),                  ),                ),              );            },            childCount: weather.list.length - 1,          ),        ),      ],    );  }}String DateUnix(int dt) {  DateTime date = new DateTime.fromMillisecondsSinceEpoch(dt * 1000);  var format = new DateFormat(" E, dd-MM-yyyy");  var dateString = format.format(date);  return dateString;}String TodayUnix(int dt) {  DateTime date = new DateTime.fromMillisecondsSinceEpoch(dt * 1000);  var format = new DateFormat("dd-MM-yyyy");  var dateString = format.format(date);  return dateString;}Widget CloudIconCheck(double day, int id) {  if (id == 0) {    // Cloud Atas    if (day >= 26.0) {      return Container(        margin: EdgeInsets.only(top: 60),        child: Icon(          Icons.cloud_off,          size: 100,          color: Colors.white,        ),      );    } else {      return Container(        margin: EdgeInsets.only(top: 60),        child: Icon(          Icons.cloud_queue,          size: 100,          color: Colors.white,        ),      );    }  } else if (id == 1) {    // Cloud BAWAH    if (day >= 26.0) {      return Container(        margin: EdgeInsets.only(left: 30),        child: Icon(          Icons.cloud_off,          size: 45,        ),      );    } else {      return Container(        margin: EdgeInsets.only(left: 30),        child: Icon(          Icons.cloud_queue,          size: 45,        ),      );    }  } else if (id== 3){    if (day >= 26.0) {      return Container(       // margin: EdgeInsets.only(left: 50),        child: Icon(          Icons.cloud_off,          size: 100,          color: Colors.black,        ),      );    } else {      return Container(       // margin: EdgeInsets.only(top: 50),        child: Icon(          Icons.cloud_queue,          size: 100,          color: Colors.black,        ),      );    }  }}Widget CloudTextCheck(double day, int id) {  if (id == 0) {    // Cloud Atas    if (day >= 26.0) {      return Container(        child: Text(          'Rainy',          style: TextStyle(fontSize: 20, color: Colors.white),        ),      );    } else {      return Container(        child: Text(          'Cloud',          style: TextStyle(fontSize: 20, color: Colors.white),        ),      );    }  } else if (id == 1) {    // Cloud BAWAH    if (day >= 26.0) {      return Container(        margin: EdgeInsets.only(left: 35, top: 5),        child: Text(          'Rainy',          style: TextStyle(fontSize: 18, color: Colors.black),        ),      );    } else {      return Container(        margin: EdgeInsets.only(left: 35, top: 5),        child: Text(          'Cloud',          style: TextStyle(fontSize: 18, color: Colors.black),        ),      );    }  } else if ( id == 3 ){    if (day >= 26.0) {      return Container(        child: Text(          'Rainy',          style: TextStyle(fontSize: 20, color: Colors.black),        ),      );    } else {      return Container(        child: Text(          'Cloud',          style: TextStyle(fontSize: 20, color: Colors.black),        ),      );    }  }}