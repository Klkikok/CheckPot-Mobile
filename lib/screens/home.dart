import 'dart:async';

import 'package:checkpot/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentTemperature = 0;
  late int currentLight = 0;
  late int currentSoilMoisture = 0;
  late int currentHumidity = 0;
  late StreamSubscription<dynamic> temperatureStream;

  @override
  void initState() {
    const eventChannel = EventChannel('checkpot/temperature');
    temperatureStream = eventChannel.receiveBroadcastStream().listen((event) {
      if (event[0] == 0) {
        setState(() {
          currentTemperature = event[1];
        });
      } else if (event[0] == 1) {
        setState(() {
          currentHumidity = event[1];
        });
      } else if (event[0] == 2) {
        setState(() {
          currentSoilMoisture = event[1];
        });
      } else if (event[0] == 3) {
        setState(() {
          currentLight = event[1];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckPot"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Temperature: "),
                Text(
                  currentTemperature.toString() + " C",
                ),
              ],
            ),
            SizedBox(height: kElementSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Light: "),
                Text(
                  (currentLight).toString(),
                ),
              ],
            ),
            SizedBox(height: kElementSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Soil moisture: "),
                Text(
                  (currentSoilMoisture).toString(),
                ),
              ],
            ),
            SizedBox(height: kElementSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Humidity: "),
                Text(
                  currentHumidity.toString() + " g/m^3",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
