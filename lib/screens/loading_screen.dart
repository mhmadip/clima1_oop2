import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima1_oop2/services/location.dart';
import 'package:http/http.dart';

import 'location_screen.dart';

const apiKey = '8137ace68448d41da44e9bf9fd681a85';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? lat, long;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLocationData();
    });
  }

  Future<void> getLocationData() async {
    
    try {
      Position position = await Geolocator.getCurrentPosition();
      lat = position.latitude;
      long = position.longitude;

      final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey',
      );

      Response response = await get(uri);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationScreen(locationWeather: response.body),
          ),
        );
      }
    } catch (e) {
      print('Error fetching location or weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: getLocationData,
          child:  Text('Get Weather'),
        ),
      ),
    );
  }
}

