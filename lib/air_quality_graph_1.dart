import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'globals.dart' as globals;

late BuildContext sameContext;
late _LineChartWidget_1_State thisState;



class LineChartWidget_1 extends StatefulWidget {
  //const LineChartWidget_1({ Key? key }) : super(key: key);

  // if airSensorValue1 has no value, it is null. That is not acceptable to FlSpot(); function.
  // if airSensorValue1 is null, assign it a value of say -1. So use tryParse for this.
  // also FlSpot(); expects a double, so int is converted to double
  // "late" keyword is used because otherwise the instance member cannot be accessed by the initializer

  // final int airSensorValue1;
  // final int airSensorValue2;
  // final int timeStampHour;
  // final int timeStampMinute;
  // final int timeStampSecond;

  // LineChartWidget_1(
  //   this.airSensorValue1,
  //   this.airSensorValue2,
  //   this.timeStampHour,
  //   this.timeStampMinute,
  //   this.timeStampSecond,
  // );


  @override
  //State<LineChartWidget_1> createState() => _LineChartWidget_1_State();
  _LineChartWidget_1_State createState() => _LineChartWidget_1_State();
}

class _LineChartWidget_1_State extends State<LineChartWidget_1> {
  late ChartSeriesController _chartSeriesController;
  

  // late  double airSensorValueGraph1 = double.tryParse(widget.airSensorValue1.toString()) ?? 0;
  // late double airSensorValueGraph2 = double.tryParse(widget.airSensorValue2.toString()) ?? 0;

  // late double timeStampHourGraph = double.tryParse(widget.timeStampHour.toString()) ?? 0;
  // late double timeStampMinuteGraph = double.tryParse(widget.timeStampMinute.toString()) ?? 0;
  // late double timeStampSecondGraph = double.tryParse(widget.timeStampSecond.toString()) ?? 0;

  
  // late var LineTitlesNew = LineTitles(widget.timeStampHour, widget.timeStampMinute, widget.timeStampSecond);
  //var LineTitlesNew = LineTitles();



  // @override
  // Widget build(BuildContext context) => SingleChildScrollView(
  @override
  Widget build(BuildContext context) {
    sameContext = context;
    thisState = this;
    
    return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      width: (globals.airSensorValueCounter <= 10) ? ((MediaQuery.of(context).size.width)-30) : (((MediaQuery.of(context).size.width)-30) + globals.airSensorValueCounter*20),
      // The first 5 graph points: full-width of the screen
      // After that: width will grow with the number of points

      child: LineChart(  
      LineChartData(
        minX: 0,
        maxX: double.parse((globals.airSensorValueCounter-1).toString()),
        //maxX: (globals.airSensorValue1Counter <= 5) ? double.parse((globals.airSensorValue1Counter-1).toString()) : 10,
        minY: 0,
        maxY: 100,
        backgroundColor: Colors.black,
        

        titlesData: LineTitles().getTitleData(),
        //titlesData: LineTitlesNew.getTitleData(),

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
            for(int counter = 0; counter< globals.airSensorValueCounter; counter++)
            //  const FlSpot(0, 70),
              FlSpot((double.parse(counter.toString())), globals.airSensorValue1Array.elementAt(counter)), // FlSpot(counter, airSensorValue1) = FlSpot(0, 10), FlSpot(1, 20), ...
            ],
            curveSmoothness: 0.4,
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
    ),
    ),
  );

  }

}



class LineTitles {
  // final int timeStampHour;
  // final int timeStampMinute;
  // final int timeStampSecond;

  // LineTitles(
  //   this.timeStampHour,
  //   this.timeStampMinute,
  //   this.timeStampSecond,
  // );

  //static getTitleData() => FlTitlesData(
  dynamic getTitleData() => FlTitlesData(
    show: true,
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false, reservedSize: 30)),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false, reservedSize: 30, getTitlesWidget: (value, titleMeta) {return const Text('');})),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30, // bottom space
        
        interval: 1,

        // Honeywell sensor takes values every 1 minute
        // The screen fills up in 10 readings (10 minutes) and becomes scrollable
        // 1 hour = 60 readings
        getTitlesWidget: (value, titleMeta) {
          debugPrint('air_quality_graph_1: valuetoInt = ${value.toInt()}');
          if(value.toInt() <= 10){
            debugPrint('air_quality_graph_1: valuetoInt less than 10!');
            // Display HH:MM:SS
            return Text('${globals.airSensorHourArray.elementAt(value.toInt())}:${globals.airSensorMinuteArray.elementAt(value.toInt())}:${globals.airSensorSecondArray.elementAt(value.toInt())}', style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
          } else if (value.toInt() <= 20){
            debugPrint('air_quality_graph_1: valuetoInt less than 60!');
            // Display HH (hourly intervals)
            return Text(globals.airSensorHourArray.elementAt(value.toInt()), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
          }
          else if (value.toInt() <= 30){
            debugPrint('air_quality_graph_1: valuetoInt less than 70!');
            return const Text('Monday!', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
          }
          else {
            return const Text('');
          }
        }


          /*

          switch(value.toInt()){
            case 0:
              if((globals.airSensorValue1Counter-1) > -1){     
                return Text(globals.airSensorValue1TimeArray.elementAt(0), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
              }
              break;
            case 1:
              if((globals.airSensorValue1Counter-1) > 0){     
                return Text(globals.airSensorValue1TimeArray.elementAt(1), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
              }
              break;
            case 2:
              if((globals.airSensorValue1Counter-1) > 1){
                return Text(globals.airSensorValue1TimeArray.elementAt(2), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);    
              }
              break;
            case 3:
              if((globals.airSensorValue1Counter-1) > 2){
                return Text(globals.airSensorValue1TimeArray.elementAt(3), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
              }
              break;
            case 4:
              if((globals.airSensorValue1Counter-1) > 3){
                return Text(globals.airSensorValue1TimeArray.elementAt(4), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
              }
              break;
            case 5:
              if((globals.airSensorValue1Counter-1) > 4){
                return Text(globals.airSensorValue1TimeArray.elementAt(5), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
              }
              break;
            case 6:
              if((globals.airSensorValue1Counter-1) > 5){
                return Text(globals.airSensorValue1TimeArray.elementAt(6), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
              }
              break;
            case 7:
              if((globals.airSensorValue1Counter-1) > 6){
                return Text(globals.airSensorValue1TimeArray.elementAt(7), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
              }
              break;
            case 8:
              if((globals.airSensorValue1Counter-1) > 7){
                return Text(globals.airSensorValue1TimeArray.elementAt(8), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
              }
              break;
            case 9:
              if((globals.airSensorValue1Counter-1) > 8){
                return Text(globals.airSensorValue1TimeArray.elementAt(9), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
              }
              break;
            case 10:
              if((globals.airSensorValue1Counter-1) > 9){
                return Text(globals.airSensorValue1TimeArray.elementAt(10), style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);      
              }
              break;

          }
        return const Text('');
        }


        */
        
        /*

        getTitlesWidget: (value, titleMeta) {  

          //return Text('${timeStampHour}:${timeStampMinute}:${timeStampSecond}', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 4),);
          switch (value.toInt()){
            //case 1:
              //return const Text('01:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 1:
              return Text('${globals.airSensorValue1TimeArray.elementAt(counter)}', style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);       
            // case 2:
            //   return Text('${globals.airSensorValue1TimeArray.elementAt(counter)}', style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            // case 3:
            //   return Text('${globals.airSensorValue1TimeArray.elementAt(counter)}', style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            
            //case 3:
              //return const Text('03:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
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

            // case 17:
            //   return Text('${timeStampHour}:${timeStampMinute}:${timeStampSecond}', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            // case 18:
            //   return Text('${timeStampHour}:${timeStampMinute}:${timeStampSecond}', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            
            case 19:
              return const Text('19:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 21:
              return const Text('21:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
            case 23:
              return const Text('23:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          }
          return const Text('');
        },

        */

        // getTitlesWidget: (value, titleMeta) {         
          // switch (value.toInt()){
          //   case 1:
          //     return const Text('01:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 3:
          //     return const Text('03:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 5:
          //     return const Text('05:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 7:
          //     return const Text('07:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 9:
          //     return const Text('09:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 11:
          //     return const Text('11:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 13:
          //     return const Text('13:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 15:
          //     return const Text('15:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 17:
          //     return const Text('17:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 19:
          //     return const Text('19:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 21:
          //     return const Text('21:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          //   case 23:
          //     return const Text('23:00', style: TextStyle(color: Colors.white, height: 1.5, fontSize: 8),);
          // }
          // return const Text('');
        // },
      ),
    ),

    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30, // left side space
        interval: 5,
        
        getTitlesWidget: (value, titleMeta) {
          switch (value.toInt()){
            case 0:
              return const Text('0', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 5:
              return const Text('5', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 10:
              return const Text('10', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 15:
              return const Text('15', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 20:
              return const Text('20', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 25:
              return const Text('25', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 30:
              return const Text('30', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 35:
              return const Text('35', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 40:
              return const Text('40', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 45:
              return const Text('45', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 50:
              return const Text('50', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 55:
              return const Text('55', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 60:
              return const Text('60', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 65:
              return const Text('65', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 70:
              return const Text('70', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 75:
              return const Text('75', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 80:
              return const Text('80', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 85:
              return const Text('85', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 90:
              return const Text('90', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
            case 95:
              return const Text('95', style: TextStyle(color: Colors.white, fontSize: 8),textAlign: TextAlign.center,);
          }
          return const Text('');
        },
      ),
    ),
  );
}