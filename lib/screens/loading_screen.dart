import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima1_oop2/services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocation()async{
    determinePosition() ;
    GeolocatorPlatform location = GeolocatorPlatform.instance;
    final position= await location.getCurrentPosition();

    print(position.latitude);
    print(position.longitude);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Get the current location
            getLocation();
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
