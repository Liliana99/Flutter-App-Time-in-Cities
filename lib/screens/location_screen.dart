import 'package:clima/common_widgets/list_target.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

var keyButton = GlobalKey();

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel _weatherModel = WeatherModel();
  int temperature;
  String weatherMessage;
  String cityName;
  String weatherIcon;

  @override
  void initState() {
    super.initState();
    _updateUI(widget.locationWeather);
  }

  void _updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get  weather data';
        cityName = '';
        return; //Exit the function in this case
      }
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = _weatherModel.getWeatherIcon(condition);
      weatherMessage = _weatherModel.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  void _showTutorial({BuildContext context}) async {
    var targets = await ListTarget(keyButton: keyButton).initTargets();
    try {
      TutorialCoachMark(context,
          targets: targets, // List<TargetFocus>
          colorShadow: Colors.blue, // DEFAULT Colors.black
          alignSkip: Alignment.bottomRight,
          textSkip: "CLOSE",
          paddingFocus: 10,
          //opacityShadow: 0.8,
          finish: () {
        print("finish");
      }, clickTarget: (target) {}, clickSkip: () {})
        ..show();
    } catch (e) {
      print('Error mostrar tutorial $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black54,
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      key: keyButton,
                      onPressed: () async {
                        _showTutorial(context: context);
                        // var weatherData = _weatherModel.getLocationWeather();
                        //_updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.info_outline, color: Colors.blue, size: 40,
                        // Icons.near_me,
                        //size: 50.0,
                        //color: Colors.blue,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var typeName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typeName != null) {
                          var weatherData =
                              await _weatherModel.getCityWeather(typeName);
                          _updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 35.0),
                child: Text(
                  "$weatherMessage in  $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
