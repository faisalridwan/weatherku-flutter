// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
    City city;
    String cod;
    double message;
    int cnt;
    List<ListElement> list;

    WeatherModel({
        this.city,
        this.cod,
        this.message,
        this.cnt,
        this.list,
    });

    factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        city: City.fromJson(json["city"]),
        cod: json["cod"],
        message: json["message"].toDouble(),
        cnt: json["cnt"],
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "city": city.toJson(),
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
    };
}

class City {
    int id;
    String name;
    Coord coord;
    String country;
    int population;
    int timezone;

    City({
        this.id,
        this.name,
        this.coord,
        this.country,
        this.population,
        this.timezone,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
    };
}

class Coord {
    double lon;
    double lat;

    Coord({
        this.lon,
        this.lat,
    });

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
    };
}

class ListElement {
    int dt;
    int sunrise;
    int sunset;
    Temp temp;
    FeelsLike feelsLike;
    int pressure;
    int humidity;
    List<Weather> weather;
    double speed;
    int deg;
    int clouds;
    double rain;

    ListElement({
        this.dt,
        this.sunrise,
        this.sunset,
        this.temp,
        this.feelsLike,
        this.pressure,
        this.humidity,
        this.weather,
        this.speed,
        this.deg,
        this.clouds,
        this.rain,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: Temp.fromJson(json["temp"]),
        feelsLike: FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        speed: json["speed"].toDouble(),
        deg: json["deg"],
        clouds: json["clouds"],
        rain: json["rain"] == null ? null : json["rain"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp.toJson(),
        "feels_like": feelsLike.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "speed": speed,
        "deg": deg,
        "clouds": clouds,
        "rain": rain == null ? null : rain,
    };
}

class FeelsLike {
    double day;
    double night;
    double eve;
    double morn;

    FeelsLike({
        this.day,
        this.night,
        this.eve,
        this.morn,
    });

    factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
    };
}

class Temp {
    double day;
    double min;
    double max;
    double night;
    double eve;
    double morn;

    Temp({
        this.day,
        this.min,
        this.max,
        this.night,
        this.eve,
        this.morn,
    });

    factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"].toDouble(),
        min: json["min"].toDouble(),
        max: json["max"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
    };
}

class Weather {
    int id;
    String main;
    String description;
    String icon;

    Weather({
        this.id,
        this.main,
        this.description,
        this.icon,
    });

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
    };
}
