import 'weather.dart';
import 'package:flutter/material.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationWeather});

  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Weather weather = Weather();

  String? cityName;
  int? temperature;
  int? condition;

  @override
  void initState() {
    super.initState();

    updatedUi(widget.locationWeather);
  }

  void updatedUi(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = '';
      }
      cityName = weatherData['name'];
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weather.getMessage(temperature!);

      condition = weatherData['weather'][0]['id'];
      weather.getWeatherIcon(condition!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/location_background.jpg'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                onTap: () async {
                  var weatherData = await weather.getLocationWeather();
                  updatedUi(weatherData);
                },
                child: Icon(
                  Icons.near_me,
                  size: 50,
                ),
              ),
              InkWell(
                onTap: () async {
                  var typeName = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CityScreen(),
                    ),
                  );
                  if (typeName != null) {
                    var weatherData =
                        await weather.getCityNameWeather(typeName);
                    updatedUi(weatherData);
                  }
                },
                child: Icon(
                  Icons.location_city,
                  size: 50,
                ),
              )
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$temperature°',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 100),
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  weather.getWeatherIcon(condition!),
                  style:
                      TextStyle(color: Colors.yellow.shade900, fontSize: 100),
                ),
              ],
            ),
            Text(
              '${weather.getMessage(temperature!)} in $cityName',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            )
          ],
        ),
      ),
    );
  }
}

// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// TextButton(
// onPressed: () {},
// child: Icon(
// Icons.near_me,
// size: 50.0,
// ),
// ),
// TextButton(
// onPressed: () {},
// child: Icon(
// Icons.location_city,
// size: 50.0,
// ),
// ),
// ],
// ),
// Padding(
// padding: EdgeInsets.only(left: 15.0),
// child: Row(
// children: <Widget>[
// Text(
// '32°',
// // style: kTempTextStyle,
// ),
// Text(
// '☀️',
// // style: kConditionTextStyle,
// ),
// ],
// ),
// ),
// Padding(
// padding: EdgeInsets.only(right: 15.0),
// child: Text(
// "It's 🍦 time in San Francisco!",
// textAlign: TextAlign.right,
// // style: kMessageTextStyle,
// ),
// ),
// ],
