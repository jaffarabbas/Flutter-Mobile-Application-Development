import 'dart:convert';

class WeatherModel {
  late num id;
  // late String country;
  late String name;
  // late num timezone;
  // late num sunrise;
  // late num sunset;
  late String main;
  // late String description;
  late String icon;
  late num temp;
  // late num feels_like;
  // late num temp_min;
  // late num temp_max;
  // late num pressure;
  late num humidity;
  late num speed;
  late num deg;
  // late num all;
  // late num lon;
  // late num lat;

  WeatherModel({
    required this.id,
    // required this.country,
    required this.name,
    // required this.timezone,
    // required this.sunrise,
    // required this.sunset,
    required this.main,
    // required this.description,
    required this.icon,
    required this.temp,
    // required this.feels_like,
    // required this.temp_min,
    // required this.temp_max,
    // required this.pressure,
    required this.humidity,
    required this.speed,
    required this.deg,
    // required this.all,
    // required this.lon,
    // required this.lat,
  });

  WeatherModel.fromJson(Map map) {
    id = map['id'];
    // country = map['country'];
    name = map['name'];
    // timezone = map['timezone'];
    // sunrise = map['sunrise'];
    // sunset = map['sunset'];
    main = map['weather'][0]['main'];
    // description = map['description'];
    icon = map['weather'][0]['icon'];
    temp = map['main']['temp'];
    // feels_like = map['feels_like'];
    // temp_min = map['temp_min'];
    // temp_max = map['temp_max'];
    // pressure = map['pressure'];
    humidity = map['main']['humidity'];
    speed = map['wind']['speed'];
    deg = map['wind']['deg'];
    // all = map['all'];
    // lon = map['lon'];
    // lat = map['lat'];
  }

  static List<WeatherModel> fromJsonList(List<dynamic> jsonList) {
    List<WeatherModel> data = [];
    jsonList.forEach((element) {
      data.add(WeatherModel.fromJson(element));
    });
    return data;
  }
}
