import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  var temperature;
  var description;
  var icon;
  String city = 'Istanbul'; // default city

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=ad90507d4eac46f683816775ba7f1bfe';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        temperature = data['main']['temp'];
        description = data['weather'][0]['main'];
        icon = data['weather'][0]['icon'];
      });
    }
  }

  Widget callWeatherImage() {
    if (description == "Clear") {
      return Image(
        image: AssetImage("assets/clear.png"),
        width: 200,
        height: 200,
      );
    } else if (description == "Clouds") {
      return Image(
        image: AssetImage("assets/cloudy.png"),
        width: 200,
        height: 200,
      );
    } else if (description == "Rain") {
      return Image(
        image: AssetImage("assets/rainy.png"),
        width: 200,
        height: 200,
      );
    } else if (description == "Snow") {
      return Image(
        image: AssetImage("assets/snowy.png"),
        width: 200,
        height: 200,
      );
    } else if (description == "Sun") {
      return Image(
        image: AssetImage("assets/sunny.png"),
        width: 200,
        height: 200,
      );
    } else if (description == "Mist") {
      return Image(
        image: AssetImage("assets/mist.png"),
        width: 200,
        height: 200,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Select a city:',
                style: TextStyle(fontSize: 32),
              ),
            ),
            // Dropdown menu for selecting the city
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                dropdownColor: Colors.red.shade100,
                value: city,
                items: [
                  DropdownMenuItem(
                    child: Text(
                      'Istanbul',
                    ),
                    value: 'Istanbul',
                  ),
                  DropdownMenuItem(
                    child: Text('Ankara'),
                    value: 'Ankara',
                  ),
                  DropdownMenuItem(
                    child: Text('New York'),
                    value: 'New York',
                  ),
                  DropdownMenuItem(
                    child: Text('Belgrade'),
                    value: 'Belgrade',
                  ),
                  DropdownMenuItem(
                    child: Text('Tokyo'),
                    value: 'Tokyo',
                  ),
                  DropdownMenuItem(
                    child: Text('Rome'),
                    value: 'Rome',
                  ),
                  DropdownMenuItem(
                    child: Text('Dubai'),
                    value: 'Dubai',
                  ),
                  DropdownMenuItem(
                    child: Text('London'),
                    value: 'London',
                  ),
                  DropdownMenuItem(
                    child: Text('Berlin'),
                    value: 'Berlin',
                  ),
                  DropdownMenuItem(
                    child: Text('Barcelona'),
                    value: 'Barcelona',
                  ),
                  DropdownMenuItem(
                    child: Text('Malatya'),
                    value: 'Malatya',
                  ),
                  DropdownMenuItem(
                    child: Text('Finland'),
                    value: 'Finland',
                  ),
                  DropdownMenuItem(
                    child: Text('Guangzhou'),
                    value: 'Guangzhou',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    city = value!;
                    getWeather();
                  });
                },
              ),
            ),
            callWeatherImage(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Temperature: ${temperature?.toString()} °C',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description: $description',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
