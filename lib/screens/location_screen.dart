import 'package:flutter/material.dart';
import 'package:weatherapp/screens/city_screen.dart';
import 'package:weatherapp/services/weather.dart';

import 'package:weatherapp/utilities/constants.dart';

import '../models/weather_message.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}


final weather = WeatherModel();




class _LocationScreenState extends State<LocationScreen> {

  String city = 'Current Location';
  String icon = '';
  String message = '';
  String temperature = '';

  @override
  void initState() {
    super.initState();
    loadWeatherData();
  }

  void loadWeatherData() async {
    try {
      var result = await weather.getWeatherData();
      if (result != null) {
        setState(() {
          temperature = result.temperature;
          icon = result.icon;
          message = result.message;
          city = result.city;
        });
      }
    } catch (e) {
      print('Error loading weather data: $e');
      setState(() {
        temperature = '--';
        icon = '🤷‍';
        message = 'Unable to get weather data';
        city = 'Unknown';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      try {
                        var result = await weather.getWeatherData();
                        if (result != null) {
                          setState(() {
                            temperature = result.temperature;
                            icon = result.icon;
                            message = result.message;
                            city = result.city;
                          });
                        }
                      } catch (e) {
                        print('Error: $e');
                      }
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: ()  async {
                      var cityName =  await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      },),);
                      if(cityName !=null){

                        var result = await weather.getWeatherDataByCity(cityName);
                        setState(() {
                          temperature = result.temperature;
                          icon = result.icon;
                          message = result.message;
                          city = result.message;
                        });
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $city!",
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
