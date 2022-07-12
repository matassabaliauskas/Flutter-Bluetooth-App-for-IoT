// ignore_for_file: camel_case_types, must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget_2 extends StatelessWidget {
  //const LineChartWidget_2({ Key? key }) : super(key: key);

  // if airSensorValue1 has no value, it is null. That is not acceptable to FlSpot(); function.
  // if airSensorValue1 is null, assign it a value of say -1. So use tryParse for this.
  // also FlSpot(); expects a double, so int is converted to double
  // "late" keyword is used because otherwise the instance member cannot be accessed by the initializer
  final int airSensorValue1;
  late  double airSensorValueGraph1 = double.tryParse(airSensorValue1.toString()) ?? 0;

  final int airSensorValue2;
  late double airSensorValueGraph2 = double.tryParse(airSensorValue2.toString()) ?? 0; 
  final int timeStampHour;
  late double timeStampHourGraph = double.tryParse(timeStampHour.toString()) ?? 0;

  final int timeStampMinute;
  late double timeStampMinuteGraph = double.tryParse(timeStampMinute.toString()) ?? 0;


  LineChartWidget_2(
    this.airSensorValue1,
    this.airSensorValue2,
    this.timeStampHour,
    this.timeStampMinute,
  );


  // debugPrint('air_quality_graph: airSensorValue1 = ${airSensorValue1}. airSensorValue2 = ${airSensorValue2}. Hour = X. Minute = Y');

  @override
  Widget build(BuildContext context) => LineChart(
    LineChartData(
      minX: 0,
      maxX: 24,
      minY: 0,
      maxY: 300,
      backgroundColor: Colors.black,
      titlesData: LineTitles.getTitleData(),

      gridData: FlGridData(
        show: true,
        verticalInterval: 1,
        horizontalInterval: 5,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white.withOpacity(0.1),
            strokeWidth: 1,
          );
        },
        drawVerticalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white.withOpacity(0.1),
            strokeWidth: 1,
          );
        },
      ),
      


      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),

      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 70),
            const FlSpot(3, 55),
            const FlSpot(6, 30),
            const FlSpot(9, 30),
            FlSpot(timeStampHourGraph, airSensorValueGraph2), // PM2.5 = 21 at 10:28
            //FlSpot(13, 50),
            // FlSpot(15, 40),
            const FlSpot(18, 30),
            const FlSpot(21, 20),
            const FlSpot(23, 5),
          ],
          curveSmoothness: 0.1,
          isCurved: true,
          barWidth: 1,
          dotData: FlDotData(show: false),
          
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.withOpacity(0.70),
              Colors.orange.withOpacity(0.70),
              Colors.green.withOpacity(0.70),
            ],
          ),

          belowBarData: BarAreaData(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.red.withOpacity(0.70),
                Colors.orange.withOpacity(0.70),
                Colors.green.withOpacity(0.70),
              ],
            ),
            show: true,
          ),
        ),
      ],
    ),
  ); 
}


class LineTitles {
  final int timeStampHour;
  final int timeStampMinute;

  LineTitles(
    this.timeStampHour,
    this.timeStampMinute,
  );


  static getTitleData() => FlTitlesData(
    show: true,
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false, reservedSize: 30)),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false, reservedSize: 30, getTitlesWidget: (value, titleMeta) {return const Text('');})),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30, // bottom space
        interval: 1,

        
        getTitlesWidget: (value, titleMeta) {
          switch (value.toInt()){
            case 1:
              return const Text('01:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 3:
              return const Text('03:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 5:
              return const Text('05:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 7:
              return const Text('07:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 9:
              return const Text('09:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 11:
              return const Text('11:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 13:
              return const Text('13:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 15:
              return const Text('15:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 17:
              return const Text('17:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 19:
              return const Text('19:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 21:
              return const Text('21:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 23:
              return const Text('23:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          }
          return const Text('');
        },
      ),
    ),

    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30, // left side space
        interval: 10,
        
        getTitlesWidget: (value, titleMeta) {
          switch (value.toInt()){
             case 0:
              return const Text('0', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 10:
              return const Text('10', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 20:
              return const Text('20', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 30:
              return const Text('30', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 40:
              return const Text('40', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 50:
              return const Text('50', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 60:
              return const Text('60', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 70:
              return const Text('70', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 80:
              return const Text('80', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 90:
              return const Text('90', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 100:
              return const Text('100', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 110:
              return const Text('110', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);  
            case 120:
              return const Text('120', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 130:
              return const Text('130', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);  
            case 140:
              return const Text('140', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 150:
              return const Text('150', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);  
            case 160:
              return const Text('160', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 170:
              return const Text('170', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);  
            case 180:
              return const Text('180', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 190:
              return const Text('190', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);  
            case 200:
              return const Text('200', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 210:
              return const Text('210', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);  
            case 220:
              return const Text('220', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 230:
              return const Text('230', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 240:
              return const Text('240', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 250:
              return const Text('250', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,); 
            case 260:
              return const Text('260', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 270:
              return const Text('270', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,); 
            case 280:
              return const Text('280', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 290:
              return const Text('290', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,); 
          }
          return const Text('');
        },
      ),
    ),
  );
}