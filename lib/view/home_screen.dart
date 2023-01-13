import 'package:climate/model/weather.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String weather = '';
  String cityName = '';

  final cityContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF181a21),
        title: const Text('Climate App'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              final currentWeather = await Weather.getCurrentWeather(
                latitude: widget.latitude,
                longitude: widget.longitude,
              );
              setState(() {
                weather = currentWeather.weather.toString();
                cityName = currentWeather.cityName;
              });
            },
            icon: const Icon(Icons.location_on_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: cityContoller,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Dubai',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(17),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final currentWeather = await Weather.getCityWeather(
                  cityName: cityContoller.text,
                );

                setState(() {
                  weather = currentWeather.weather.toString();
                  cityName = currentWeather.cityName;
                });
              },
              child: const Text('Get Weather'),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Current Weather : $weather'),
                    Text('City Name : $cityName'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
