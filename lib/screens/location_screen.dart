import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:clima1_oop2/utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';
import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {
  final String locationWeather;

  const LocationScreen({Key? key, required this.locationWeather}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherModel weather = WeatherModel();
  int? temperature;
  String? cityName;
  int? condition;
  String? weatherIcon;
  String? weatherMsg;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(String rawWeatherData) {
    try {
      final weatherData = jsonDecode(rawWeatherData);

      setState(() {
        double temp = weatherData['main']['temp'] - 273.15;
        temperature = temp.toInt();
        condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];
        weatherIcon = weather.getWeatherIcon(condition!);
        weatherMsg = weather.getMessage(temperature!);
        print("$cityName $condition $temperature $weatherMsg $weatherIcon");
      });
    } catch (e) {
      print('Failed to update UI: $e');
      setState(() {
        temperature = 0;
        cityName = 'Unknown';
        weatherIcon = '❓';
        weatherMsg = 'Unable to get weather data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white54, BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const LoadingScreen();
                          }));
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const CityScreen();
                          }));
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temperature != null ? '$temperature°' : '--',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon ?? '',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMsg != null && cityName != null
                      ? "$weatherMsg in $cityName!"
                      : "Unable to retrieve weather info.",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
