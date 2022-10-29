import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  WeatherFactory wf = WeatherFactory("d5cd56e0736b66e2b79f53b941f03a68");
  Future<Weather> fetchData() async {
    Weather data = await wf.currentWeatherByCityName('Silchar');
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
      ),
      body: FutureBuilder<Weather>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Weather weather = snapshot.data;
          if (snapshot.hasData) {
            return Center(
              child: Column(children: [Text(weather.temperature.toString())]),
            );
          } else {
            return Center(
              child: Text("Getting your weather"),
            );
          }
        },
      ),
    );
  }
}
