import 'dart:async';

import 'package:checkpot/utils/constants.dart';
import 'package:checkpot/utils/themes.dart';
import 'package:checkpot/widgets/details_tile.dart';
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
  late int danger = 0;
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
      } else if (event[0] == 4) {
        setState(() {
          danger = event[1];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CheckPot"),
        toolbarHeight: 50,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                danger == 1
                    ? Column(
                        children: [
                          SizedBox(height: kElementSpacing),
                          Text(
                            "DHT SENSOR IS NOT WORKING",
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(height: kElementSpacing),
                        ],
                      )
                    : const SizedBox(height: kElementSpacing * 2),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: Image.asset(
                          fit: BoxFit.fitWidth,
                          "assets/images/zumbul.jpeg",
                          height: 130,
                          width: 130,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Zumbul-aga",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(fontSize: 25),
                            ),
                            const SizedBox(height: kElementSpacing / 4),
                            Text(
                              "Hyacinthus",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kElementSpacing),
                const Divider(
                  color: cpGrey,
                ),
                const SizedBox(height: kElementSpacing),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      DetailsTile(
                        title: "Temperature: ",
                        value: "${currentTemperature.toString()} C",
                      ),
                      SizedBox(height: kElementSpacing),
                      DetailsTile(
                        title: "Light: ",
                        value: currentLight.toString(),
                      ),
                      SizedBox(height: kElementSpacing),
                      DetailsTile(
                        title: "Soil moisture: ",
                        value: "${(currentSoilMoisture).toString()} g/m^3",
                      ),
                      SizedBox(height: kElementSpacing),
                      DetailsTile(
                        title: "Humidity: ",
                        value: "${currentHumidity.toString()} g/m^3",
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: Container(
                //         padding: const EdgeInsets.only(left: 20, right: 20),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 const Text("Temperature: "),
                //                 Text(
                //                   "${currentTemperature.toString()} C",
                //                 ),
                //               ],
                //             ),
                //             const SizedBox(height: kElementSpacing),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 const Text("Light: "),
                //                 Text(
                //                   (currentLight).toString(),
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 const Text("Soil moisture: "),
                //                 Text(
                //                   "${(currentSoilMoisture).toString()} g/m^3",
                //                 ),
                //               ],
                //             ),
                //             const SizedBox(height: kElementSpacing),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 const Text("Humidity: "),
                //                 Text(
                //                   "${currentHumidity.toString()} g/m^3",
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Expanded(
                  child: SizedBox(),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Water the plant"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
