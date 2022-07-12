// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'globals.dart' as globals;
// import 'package:fl_chart/fl_chart.dart'; // for the fl_chart!
//import 'air_quality_graph_1.dart'; // fl_charts pm 2.5 graph
//import 'air_quality_graph_2.dart'; // fl_charts pm 10 graph
import 'air_quality_graph_3.dart'; // syncfusion pm 2.5 graph
import 'air_quality_graph_4.dart'; // syncfusion pm 10 graph


// This widget is for displaying the 5th air purifier function to the air purifier main screen: 
// air quality PM2.5 value, PM10 value and the graph of those values
// Service UUID: 00035b03-58e6-07dd-021a-08123a000300
// Characteristic UUID: 00035b03-58e6-07dd-021a-08123a000305

class ServiceTile_5 extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile_5> characteristicTiles;

  const ServiceTile_5(
      {Key? key, required this.service, required this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.isNotEmpty) {
      return Column(
        children: characteristicTiles,
      );
    } 
    else {
      return Container();
    }
  }
}

class CharacteristicTile_5 extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;
  final VoidCallback? onNotificationPressed;


  const CharacteristicTile_5(
      {Key? key,
      required this.characteristic,
      this.onReadPressed,
      this.onWritePressed,
      this.onNotificationPressed})
      : super(key: key);

  @override
  State<CharacteristicTile_5> createState() => _CharacteristicTile_5State();
}

class _CharacteristicTile_5State extends State<CharacteristicTile_5> {
  IconButton button5Notify = IconButton(
    onPressed: () => {},
    icon: const Icon(null),
  );

  @override
  void initState() {
    debugPrint('air_purifier_widget_5: initState()');
    Timer(const Duration(milliseconds: 3000), () {
      button5Notify.onPressed?.call();
      debugPrint('air_purifier_widget_5: onNotificationPressed after 5 second!');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: widget.characteristic.value,
      initialData: widget.characteristic.lastValue,
      builder: (c, snapshot) {

      // PM 2.5 normal range: [good = 0->12 μg/m3] [moderate = 13->35 μg/m3] [bad = 36->55 μg/m3] [dangerous = > 56 μg/m3]
      // PM 10 normal range: [good = 0->54 μg/m3] [moderate = 55->154 μg/m3] [bad = 155->254 μg/m3] [dangerous = > 255 μg/m3]
      if(widget.characteristic.uuid.toString() == '00035b03-58e6-07dd-021a-08123a000305'){

        // old format: [XX, YY]. New format: [X, X, X, Y, Y, Y]
        final snapshotData = snapshot.data;
        //debugPrint('air_purifier_widget_5: snapshot.data = $snapshotData');

        late int airSensorValue1;
        late double airSensorValueDouble1;
        late int airSensorValue2;
        late double airSensorValueDouble2;

        late var airSensorValue1Color;
        late var airSensorValue2Color;
        late String airSensorValue1Warning;
        late String airSensorValue2Warning;


        if(snapshotData.toString() == '[]'){
          //debugPrint("air_purifier_widget_5: First Initialization!");

          airSensorValue1 = 0;
          airSensorValueDouble1 = 0;
          airSensorValue2 = 0;
          airSensorValueDouble2 = 0;
          airSensorValue1Color = Colors.black;
          airSensorValue1Warning = '';
          airSensorValue2Color = Colors.black;
          airSensorValue2Warning = '';

          globals.airSensorValue1Array.clear(); // clear the air sensor PM2.5 array
          globals.airSensorValue2Array.clear(); // clear the air sensor PM10 array
          globals.airSensorValueCounter = 0; // clear air sensor array counter
          globals.airSensorValueFlag = 0; // clear air sensor flag

          globals.airSensorYear = DateTime.now().year; // clear time
          globals.airSensorMonth = DateTime.now().month;
          globals.airSensorDay = DateTime.now().day;
          globals.airSensorHourArray.clear();
          globals.airSensorMinuteArray.clear();
          globals.airSensorSecondArray.clear();

          return Column(
            children: [
              button5Notify = IconButton(
                onPressed: widget.onNotificationPressed,
                tooltip: "PM2.5/PM10 Air Values, Real-Time Air Quality Graphing",
                iconSize: 150,
                splashRadius: 1,
                icon: Image.asset(
                'assets/images/air_purifier/graph_color_1.png',
                color: Colors.black.withOpacity(0.8),
                colorBlendMode: BlendMode.darken,
                ),
              ),
            const Text(
              "Click to Monitor Air Quality \n& View Sensors' Graphs",
              style: TextStyle(fontSize: 10,color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
      else 
      {
        List<String> splitSnapshotData = snapshotData.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        // debugPrint('air_purifier_widget_5: splitSnapshotData = $splitSnapshotData');

        final Map<int, String> airSensorValues = {
        for (int i = 0; i < splitSnapshotData.length; i++)
            i: splitSnapshotData[i]
        };

        // Parse 6 byte bluetooth input and convert decimals to integers
        int airSensorValueDecimal0 = int.tryParse(airSensorValues[0].toString()) ?? 0;
        int airSensorValueInt0 = int.tryParse(String.fromCharCode(airSensorValueDecimal0)) ?? 0;

        int airSensorValueDecimal1 = int.tryParse(airSensorValues[1].toString()) ?? 0;
        int airSensorValueInt1 = int.tryParse(String.fromCharCode(airSensorValueDecimal1)) ?? 0;

        int airSensorValueDecimal2 = int.tryParse(airSensorValues[2].toString()) ?? 0;
        int airSensorValueInt2 = int.tryParse(String.fromCharCode(airSensorValueDecimal2)) ?? 0;

        int airSensorValueDecimal3 = int.tryParse(airSensorValues[3].toString()) ?? 0;
        int airSensorValueInt3 = int.tryParse(String.fromCharCode(airSensorValueDecimal3)) ?? 0;

        int airSensorValueDecimal4 = int.tryParse(airSensorValues[4].toString()) ?? 0;
        int airSensorValueInt4 = int.tryParse(String.fromCharCode(airSensorValueDecimal4)) ?? 0;

        int airSensorValueDecimal5 = int.tryParse(airSensorValues[5].toString()) ?? 0;
        int airSensorValueInt5 = int.tryParse(String.fromCharCode(airSensorValueDecimal5)) ?? 0;

      
        String airSensorValue1Temp = airSensorValueInt0.toString() + airSensorValueInt1.toString() + airSensorValueInt2.toString();
        airSensorValue1 = int.tryParse(airSensorValue1Temp) ?? -1; // PM 2.5 integer value
        airSensorValueDouble1 = double.tryParse(airSensorValue1Temp) ?? -1; // PM 2.5 double value

        String airSensorValue2Temp = airSensorValueInt3.toString() + airSensorValueInt4.toString() + airSensorValueInt5.toString();
        airSensorValue2 = int.tryParse(airSensorValue2Temp) ?? -1; // PM 10 integer value
        airSensorValueDouble2 = double.tryParse(airSensorValue2Temp) ?? -1; // PM 10 double value


        // Add all these processed integer / double variables into global arrays!
        globals.airSensorValue1Array.add(airSensorValueDouble1);
        globals.airSensorValue2Array.add(airSensorValueDouble2);
        globals.airSensorValueFlag++; // new value is added, indicate flag that it has been added
        globals.airSensorValueCounter++; // counts the length of the air sensor array

        globals.airSensorHourArray.add(((DateTime.now()).hour).toString());
        globals.airSensorMinuteArray.add(((DateTime.now()).minute).toString());
        globals.airSensorSecondArray.add((( DateTime.now()).second).toString());

        //debugPrint('air_purifier_widget_5: airSensorValue1Array = ${globals.airSensorValue1Array}');
        //debugPrint('air_purifier_widget_5: airSensorValue2Array = ${globals.airSensorValue2Array}');
        //// debugPrint('air_purifier_widget_5: globals.airSensorTimeArray: ${globals.airSensorYear}/${globals.airSensorMonth}/${globals.airSensorDay}');
        //debugPrint('air_purifier_widget_5: globals.airSensorTimeArray: HH:MM:SS=\n${globals.airSensorHourArray}:\n${globals.airSensorMinuteArray}:\n${globals.airSensorSecondArray}');
        //// debugPrint('air_purifier_widget_5: globals.airSensorValueCounter = ${globals.airSensorValueCounter}');

        if(airSensorValue1 <= 12) {
          airSensorValue1Color = Colors.green;
          airSensorValue1Warning = 'GOOD';
        } else if (airSensorValue1 <= 35){
          airSensorValue1Color = Colors.orangeAccent;
          airSensorValue1Warning = 'MODERATE';
        } else if (airSensorValue1 <= 55){
          airSensorValue1Color = Colors.redAccent;
          airSensorValue1Warning = 'BAD';
        } else {
          airSensorValue1Color = Colors.red;
          airSensorValue1Warning = 'DANGEROUS';
        }
      

        if(airSensorValue2 <= 54) {
          airSensorValue2Color = Colors.green;
          airSensorValue2Warning = 'GOOD';
        } else if (airSensorValue2 <= 154){
          airSensorValue2Color = Colors.orangeAccent;
          airSensorValue2Warning = 'MODERATE';
        } else if (airSensorValue2 <= 254){
          airSensorValue2Color = Colors.redAccent;
          airSensorValue2Warning = 'BAD';
        } else {
          airSensorValue2Color = Colors.red;
          airSensorValue2Warning = 'DANGEROUS';
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center, // vertically centered
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center, // horizontally centered
                children: [

                  IconButton(            
                    onPressed: () => {
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                      return LineChartPage_1();
                      })),
                    },
                    tooltip: 'Load PM2.5 Graph',
                    iconSize: 100,
                    splashRadius: 1,
                    alignment: Alignment.bottomCenter,
                    icon: Image.asset(
                    'assets/images/air_purifier/graph_color_2.png',
                    ),
                  ),

                  TextButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                      return LineChartPage_1();
                      })),
                    },
                    child: Text(
                      'PM 2.5: $airSensorValue1 \n[$airSensorValue1Warning]',
                       style: TextStyle(fontSize: 10, color: airSensorValue1Color),
                       textAlign: TextAlign.center,
                    ),
                  ),

                ],
              ),

              SizedBox(width: MediaQuery.of(context).size.width * 0.2),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  IconButton(            
                    onPressed: () => {
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                      return LineChartPage_2();
                      })),
                    },
                    tooltip: 'Load PM10 Graph',
                    iconSize: 100,
                    splashRadius: 1,
                    alignment: Alignment.bottomCenter,
                    icon: Image.asset(
                    'assets/images/air_purifier/graph_color_3.png',
                    ),
                  ),

                  TextButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                      return LineChartPage_2();
                      })),
                    }, 
                    child: Text(
                      'PM 10: $airSensorValue2 \n[$airSensorValue2Warning]',
                      style: TextStyle(fontSize: 10, color: airSensorValue2Color),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

            ],
          );
      }
      }
      else {
        return Container();
      }
      },
    );
  }
}

// PM 2.5 Graph Widget Page
class LineChartPage_1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Air Quality: PM2.5'), 
        backgroundColor: Colors.black,
        centerTitle: true,),
        body: Container(
          color: Colors.black,
          child: PageView(
            children: [
              Card(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                  // child: LineChartWidget_1(), // fl_charts graph 
                  child: LineChartWidget_3(), // syncfusion graph
                  ),
              ),
            ]
          ),
        ),
  );
}

// PM 10 Graph Widget Page
class LineChartPage_2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Air Quality Data: PM10'),
          backgroundColor: Colors.black,
          centerTitle: true,),
        body: Container(
          color: Colors.black,
          child: PageView(
            children: [
              Card(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                  // child: LineChartWidget_2(), // fl_charts graph
                  child: LineChartWidget_4(), // syncfusion graph
                ),
              ),
            ]
          ),
        ),
  );
}