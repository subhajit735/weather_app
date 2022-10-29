import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String city = "Guwahati";
  String? error;
  TextEditingController cityinp = TextEditingController();
  WeatherFactory wf = WeatherFactory("d5cd56e0736b66e2b79f53b941f03a68");
  Future<Weather?> fetchData() async {
    try {
      Weather data = await wf.currentWeatherByCityName(city);

      return data;
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            onSubmitted: (text) {
              setState(() {
                city = text;
              });
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Enter Name',
                hintText: 'Enter Your Name'),
          ),
          FutureBuilder<Weather?>(
            future: fetchData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Weather weather = snapshot.data;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weather.temperature.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(weather.humidity.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(weather.cloudiness.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              } else {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(error ?? 'Getting your weather...'),
                    CircularProgressIndicator(),
                  ],
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
