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
                  ], <double>[0, 0.12, 0.35, 0.55, 1],
                );
              },
              
              dataSource: _chartData,
              xValueMapper: (AirData_1 data_1, _) => data_1.time,
              yValueMapper: (AirData_1 data_1, _) => data_1.data_1,
            //   borderWidth: 1,
            //   borderGradient: LinearGradient(
            //     begin: Alignment.bottomCenter,
            //     end: Alignment.topCenter,
            //     stops: const [0, 0.25, 1],
            //     colors: [
            //     Colors.green.withOpacity(0.9),
            //     Colors.yellow.withOpacity(0.9),
            //     Colors.red.withOpacity(0.9),
            //     ],
            // ),
              splineType: SplineType.cardinal,
              cardinalSplineTension: 0.1,
              
              // enableTooltip: true,
            ),
          ],

          trackballBehavior: TrackballBehavior(
            enable: true,
            lineColor: const Color.fromARGB(255, 255, 0, 0),
            activationMode: ActivationMode.longPress,
          ),

          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
            zoomMode: ZoomMode.x,
          ),
          
         
          primaryXAxis: DateTimeAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            dateFormat: DateFormat.Hms(),
            labelStyle: const TextStyle(color: Colors.white, fontSize: 8),
            //minimum: DateTime(globals.airSensorValue1YearArray, globals.airSensorValue1MonthArray, globals.airSensorValue1DayArray, int.parse(globals.airSensorValue1HourArray.elementAt(0)), int.parse(globals.airSensorValue1MinuteArray.elementAt(0)), int.parse(globals.airSensorValue1SecondArray.elementAt(0))),
            //maximum: DateTime(2022, 6, 2, 14, 25, 0),
            majorGridLines: const MajorGridLines(
              width: 1,
              color: Color.fromARGB(30, 255, 255, 255),
            ),
          ),
          primaryYAxis: NumericAxis(
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
    if(globals.airSensorValue1Flag != 0){
      //debugPrint('air_quality_graph_3: globals.airSensorValue1Flag = ${globals.airSensorValue1Flag}');
      //debugPrint('air_quality_graph_3: new value = ${globals.airSensorValue1Array.elementAt(counter)}');
      _chartData.add(AirData_1(
        DateTime(globals.airSensorYear, globals.airSensorMonth, globals.airSensorDay, (int.tryParse(globals.airSensorHourArray.elementAt(counter)) ?? 0), (int.tryParse(globals.airSensorMinuteArray.elementAt(counter)) ?? 0), (int.tryParse(globals.airSensorSecondArray.elementAt(counter)) ?? 0)), 
        globals.airSensorValue1Array.elementAt(counter))
      );
      //_chartData.removeAt(0);
      
      _chartSeriesController.updateDataSource(
        addedDataIndex: _chartData.length - 1,
        //removedDataIndex: 0,
      );
      counter++;
      globals.airSensorValue1Flag--;
    } else if (globals.airSensorValue1Flag == 0){
      now = DateTime.now();
      _chartData.add(AirData_1(
        DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second), 
        0
      ));      
      _chartSeriesController.updateDataSource(
        addedDataIndex: _chartData.length - 1,
      );
    }
  }

  List<AirData_1> getChartData() {
    final List<AirData_1> chartData = [
      for(counter = 0; counter< globals.airSensorValue1Counter; counter++)
        //AirData_1(DateTime(2022, 6, 1, int.parse(globals.airSensorValue1HourArray.elementAt(counter))), globals.airSensorValue1Array.elementAt(counter)), // FlSpot(counter, airSensorValue1) = FlSpot(0, 10), FlSpot(1, 20), ...
        AirData_1(
          DateTime(globals.airSensorYear, globals.airSensorMonth, globals.airSensorDay, (int.tryParse(globals.airSensorHourArray.elementAt(counter)) ?? 0), (int.tryParse(globals.airSensorMinuteArray.elementAt(counter)) ?? 0), (int.tryParse(globals.airSensorSecondArray.elementAt(counter)) ?? 0)), 
          globals.airSensorValue1Array.elementAt(counter)
        ),
    
    ];
    globals.airSensorValue1Flag = 0;
    return chartData;
  }
}


class AirData_1 {
  AirData_1(this.time, this.data_1);
  final DateTime time;
  final double data_1;
}
