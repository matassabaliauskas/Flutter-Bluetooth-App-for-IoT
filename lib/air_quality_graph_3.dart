// ignore_for_file: camel_case_types, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'globals.dart' as globals;


class LineChartWidget_3 extends StatefulWidget {
  @override
  _LineChartWidget_3_State createState() => _LineChartWidget_3_State();
}

class _LineChartWidget_3_State extends State<LineChartWidget_3> {
  late List<AirData_1> _chartData;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    _chartData = getChartData();
    Timer.periodic(const Duration(seconds: 5), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCartesianChart(
          plotAreaBorderWidth: 0,
          backgroundColor: const Color.fromARGB(255, 0, 0 , 0),

          series: <SplineAreaSeries>[
            SplineAreaSeries<AirData_1, DateTime>(
              animationDuration: 0,
              onRendererCreated: (ChartSeriesController controller){
                _chartSeriesController = controller;
              },
              onCreateShader: (ShaderDetails details) {
                return ui.Gradient.linear(
                  details.rect.bottomCenter,
                  details.rect.topCenter, 
                  const <Color>[
                  Color.fromARGB(150, 0, 255, 0),
                  Color.fromARGB(150, 128, 255, 0),
                  Color.fromARGB(150, 255, 255, 0),
                  Color.fromARGB(150, 255, 128, 0),
                  Color.fromARGB(150, 255, 0, 0),
                  ], 
                  const <double>[0, 0.12, 0.35, 0.55, 1],
                );
              },
              
              dataSource: _chartData,
              xValueMapper: (AirData_1 data_1, _) => data_1.time,
              yValueMapper: (AirData_1 data_1, _) => data_1.data_1,
              splineType: SplineType.cardinal,
              cardinalSplineTension: 0.1,
            ),
          ],

          trackballBehavior: TrackballBehavior(
            enable: true,
            lineColor: const Color.fromARGB(255, 255, 0, 0),
            activationMode: ActivationMode.longPress,
            tooltipSettings: const InteractiveTooltip(
              format: 'point.x : point.y',
              color: Colors.red
            ),
          ),

          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: false, // zooming is too glitchy
            enablePanning: false, // panning only works while zoomed - glitchy...
            zoomMode: ZoomMode.x,
          ),
          
         
          primaryXAxis: DateTimeAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            dateFormat: DateFormat.Hms(),
            labelStyle: const TextStyle(color: Colors.white, fontSize: 8),
            majorGridLines: const MajorGridLines(
              width: 1,
              color: Color.fromARGB(30, 255, 255, 255),
            ),
          ),
          primaryYAxis: NumericAxis(
            visibleMinimum: 0,
            //visibleMaximum: 100,
            interval: 1,
            labelStyle: const TextStyle(color: Colors.white, fontSize: 8),
            majorGridLines: const MajorGridLines(
              width: 1,
              color: Color.fromARGB(30, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }

  late int counter = 0;
  late double updateTimescale = double.parse(counter.toString());
  late DateTime now;

  void updateDataSource(Timer timer){
    if(globals.airSensorValueFlag != 0){
      debugPrint('air_quality_graph_3: globals.airSensorValueFlag = ${globals.airSensorValueFlag}');
      //debugPrint('air_quality_graph_3: new value = ${globals.airSensorValue1Array.elementAt(counter)}');
      _chartData.add(AirData_1(
        DateTime(globals.airSensorYear, globals.airSensorMonth, globals.airSensorDay, (int.tryParse(globals.airSensorHourArray.elementAt(counter)) ?? 0), (int.tryParse(globals.airSensorMinuteArray.elementAt(counter)) ?? 0), (int.tryParse(globals.airSensorSecondArray.elementAt(counter)) ?? 0)), 
        globals.airSensorValue1Array.elementAt(counter))
      );
      _chartSeriesController.updateDataSource(
        addedDataIndex: _chartData.length - 1,
      );
      counter++;
      globals.airSensorValueFlag--;
      globals.airSensorSleepingFlag = 0;
    } 
    else if (globals.airSensorValueFlag == 0)
    {
      // globals.airSensorSleepingFlag++;
      // debugPrint('air_quality_graph_3: Preparing to sleep! airSensorSleepingFlag = ${globals.airSensorSleepingFlag}');

      // if (globals.airSensorSleepingFlag > 5){
      //   globals.airSensorHourArray.add((DateTime.now().hour).toString());
      //   globals.airSensorMinuteArray.add((DateTime.now().minute).toString());
      //   globals.airSensorSecondArray.add((DateTime.now().second).toString());

      //   globals.airSensorValue1Array.add(0.00);
      //   globals.airSensorValue2Array.add(0.00);
      //   globals.airSensorValueCounter++;
      //   //debugPrint('Air Sensor is sleeping! Adding zero value: ${globals.airSensorValue1Array}, ${globals.airSensorValue2Array}');

      //   _chartData.add(AirData_1(
      //     DateTime(globals.airSensorYear, globals.airSensorMonth, globals.airSensorDay, (int.tryParse(globals.airSensorHourArray.elementAt(counter)) ?? 0), (int.tryParse(globals.airSensorMinuteArray.elementAt(counter)) ?? 0), (int.tryParse(globals.airSensorSecondArray.elementAt(counter)) ?? 0)), 
      //     globals.airSensorValue1Array.elementAt(counter))
      //   );
        
      //   _chartSeriesController.updateDataSource(
      //     addedDataIndex: _chartData.length - 1,
      //   );
      //   counter++;
      // }
    }
  }

  List<AirData_1> getChartData() {
    final List<AirData_1> chartData = [
      for(counter = 0; counter< globals.airSensorValueCounter; counter++)
        AirData_1(
          DateTime(globals.airSensorYear, globals.airSensorMonth, globals.airSensorDay, (int.tryParse(globals.airSensorHourArray.elementAt(counter)) ?? 0), (int.tryParse(globals.airSensorMinuteArray.elementAt(counter)) ?? 0), (int.tryParse(globals.airSensorSecondArray.elementAt(counter)) ?? 0)), 
          globals.airSensorValue1Array.elementAt(counter)
        ),
    ];
    globals.airSensorValueFlag = 0;
    return chartData;
  }
}


class AirData_1 {
  AirData_1(this.time, this.data_1);
  final DateTime time;
  final double data_1;
}
