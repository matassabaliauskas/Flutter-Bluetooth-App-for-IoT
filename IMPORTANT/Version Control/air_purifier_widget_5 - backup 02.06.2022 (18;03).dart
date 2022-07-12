// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:fl_chart/fl_chart.dart'; // for the fl_chart!
import 'air_quality_graph_1.dart'; // pm 2.5 graph
import 'air_quality_graph_2.dart'; // pm 10 graph
import 'air_quality_graph_3.dart'; // syncfusion graph
import 'globals.dart' as globals;

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

class CharacteristicTile_5 extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {

      // PM 2.5 normal range: [good = 0->12 μg/m3] [moderate = 13->35 μg/m3] [bad = 36->55 μg/m3] [dangerous = > 56 μg/m3]
      // PM 10 normal range: [good = 0->54 μg/m3] [moderate = 55->154 μg/m3] [bad = 155->254 μg/m3] [dangerous = > 255 μg/m3]
      if(characteristic.uuid.toString() == '00035b03-58e6-07dd-021a-08123a000305'){

        var airSensorValue1Color;
        var airSensorValue2Color;
        String airSensorValue1Warning = '';
        String airSensorValue2Warning = '';

        var timeStamp = DateTime.now();
        int timeStampHour = timeStamp.hour;
        int timeStampMinute = timeStamp.minute;
        int timeStampSecond = timeStamp.second;
        // String timeStampString = (((DateTime.now()).hour).toString()) + ':' + (((DateTime.now()).minute).toString()) + ':' + (((DateTime.now()).second).toString());
        // debugPrint('air_purifier_widget_5: Time: ${timeStamp}, Hour: ${timeStamp.hour}, Minute = ${timeStamp.minute}');
        // old format: [XX, YY]. New format: [X, X, X, Y, Y, Y]
        final snapshotData = snapshot.data;
        // debugPrint('air_purifier_widget_5: snapshot.data = $snapshotData');
        
        final splitSnapshotData = snapshotData.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        // debugPrint('air_purifier_widget_5: splitSnapshotData = $splitSnapshotData');

        final Map<int, String> airSensorValues = {
        for (int i = 0; i < splitSnapshotData.length; i++)
            i: splitSnapshotData[i]
        };

        String airSensorValue1Temp = (airSensorValues[0].toString());
        int airSensorValue1 = int.tryParse(airSensorValue1Temp) ?? -1; // PM 2.5 integer value
        double airSensorValueDouble1 = double.tryParse(airSensorValue1Temp) ?? -1; // PM 2.5 integer value

        String airSensorValue2Temp = (airSensorValues[1].toString());
        int airSensorValue2 = int.tryParse(airSensorValue2Temp) ?? -1; // PM 10 integer value

        

        if(snapshotData.toString() == '[]') {
          globals.airSensorYear = DateTime.now().year;
          globals.airSensorMonth = DateTime.now().month;
          globals.airSensorDay = DateTime.now().day;

          globals.airSensorValue1Array.clear(); // clear the air sensor value array
          globals.airSensorHourArray.clear(); // clear time
          globals.airSensorMinuteArray.clear();
          globals.airSensorSecondArray.clear();
          globals.airSensorValue1Counter = 0; // clear air sensor array counter
          globals.airSensorValue1Flag = 0; // clear air sensor flag
        } else
        {     
          globals.airSensorValue1Array.add(airSensorValueDouble1);
          globals.airSensorValue1Flag++; // new value is added, indicate flag that it has been added


          globals.airSensorHourArray.add((((DateTime.now()).hour).toString()));
          globals.airSensorMinuteArray.add((((DateTime.now()).minute).toString()));
          globals.airSensorSecondArray.add((((DateTime.now()).second).toString()));
          globals.airSensorValue1Counter++;

          debugPrint('air_purifier_widget_5: airSensorValue1Array = ${globals.airSensorValue1Array}');
          debugPrint('air_purifier_widget_5: globals.airSensorTimeArray = ${globals.airSensorYear}/${globals.airSensorMonth}/${globals.airSensorDay}, HH:MM:SS=${globals.airSensorHourArray}:${globals.airSensorMinuteArray}:${globals.airSensorSecondArray}');
          debugPrint('air_purifier_widget_5: globals.airSensorValue1Counter = ${globals.airSensorValue1Counter}');
          debugPrint('air_purifier_widget_5: globals.airSensorValue1Flag = ${globals.airSensorValue1Flag}');

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


        // debugPrint('air_purifier_widget_5: airSensorValue1 = $airSensorValue1');
        // debugPrint('air_purifier_widget_5: airSensorValue2 = $airSensorValue2');      
        if(snapshotData.toString() == '[]'){
          return Column(
          children: [
            IconButton(
              onPressed: onNotificationPressed,
              iconSize: 150,
              // splashRadius: 1,
              icon: Image.asset(
              'assets/images/air_purifier/graph_color.png',
              color: Colors.black.withOpacity(0.8),
              colorBlendMode: BlendMode.darken,
              ),
            ),
          const Text(
            'load value',
            style: TextStyle(fontSize: 10,color: Colors.white),
          ),
          ],
        );
      } 
      else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start, // vertically
          mainAxisAlignment: MainAxisAlignment.start,
            children: [

            ///////////////////////////////////////////////////////////////
            // Delete later!
              Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('PM 2.5 (μg/m3): \n0 < GOOD < 12) \n13 < MODERATE < 35 \n36 < BAD < 55 \n56 < DANGEROUS < ∞', style: TextStyle(color: Colors.white, fontSize: 8), textAlign: TextAlign.center),
                  SizedBox(height: 30),
                  Text('PM 10 (μg/m3): \n0 < GOOD < 54) \n55 < MODERATE < 154 \n155 < BAD < 254 \n255 < DANGEROUS < ∞', style: TextStyle(color: Colors.white, fontSize: 8), textAlign: TextAlign.center,),
                ],
              ),

              const SizedBox(width: 20),
            // Delete later!
            /////////////////////////////////////////////////////////////

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.orange,
                        width: 2,
                        style: BorderStyle.solid
                      ), 
                    borderRadius: BorderRadius.circular(5)
                    ),
                    alignment: Alignment.center,
                  ),
                  onPressed: () => {
                    onNotificationPressed,
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                    //return LineChartPage_1(airSensorValue1, airSensorValue2, timeStampHour, timeStampMinute, timeStampSecond);
                    return LineChartPage_1();
                    })),
                  },
                  child: Text(
                    'PM 2.5: $airSensorValue1 \nStatus: [$airSensorValue1Warning]',
                    style: TextStyle(fontSize: 15,color: airSensorValue1Color),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.orange,
                        width: 2,
                        style: BorderStyle.solid
                      ), 
                    borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  //onLongPress: onWritePressed,
                  onPressed: () => {
                    onNotificationPressed,
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                    return LineChartPage_2(airSensorValue1, airSensorValue2, timeStampHour, timeStampMinute, timeStampSecond);
                    })),
                  }, 
                  child: Text(
                    'PM 10: $airSensorValue2 \nStatus: [$airSensorValue2Warning]',
                    style: TextStyle(fontSize: 15,color: airSensorValue2Color),
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
                  // child: LineChartWidget_1(),
                  child: LineChartWidget_3(),
                  // child: LineChartWidget_1(airSensorValue1, airSensorValue2, timeStampHour, timeStampMinute, timeStampSecond),
                ),
              ),
            ]
          ),
        ),
  );
}

class LineChartPage_2 extends StatelessWidget {
  final int airSensorValue1;
  final int airSensorValue2;
  final int timeStampHour;
  final int timeStampMinute;
    final int timeStampSecond;

  const LineChartPage_2(
    this.airSensorValue1,
    this.airSensorValue2,
    this.timeStampHour,
    this.timeStampMinute,
    this.timeStampSecond,
  );

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
                  child: LineChartWidget_2(airSensorValue1, airSensorValue2, timeStampHour, timeStampMinute),
                  //child: LineChartWidget_2(airSensorValue1, airSensorValue2, timeStampHour, timeStampMinute, timeStampSecond),
                ),
              ),
            ]
          ),
        ),
  );
}