// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'globals.dart' as globals;
// This widget is for displaying the 3rd air purifier function to the air purifier main screen: timer icon and timer status
// Service UUID: 00035b03-58e6-07dd-021a-08123a000300
// Characteristic UUID: 00035b03-58e6-07dd-021a-08123a000303

class ServiceTile_3 extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile_3> characteristicTiles;

  const ServiceTile_3(
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

class CharacteristicTile_3 extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;
  final VoidCallback? onNotificationPressed;

  const CharacteristicTile_3(
      {Key? key,
      required this.characteristic,
      this.onReadPressed,
      this.onWritePressed,
      this.onNotificationPressed})
      : super(key: key);

  @override
  State<CharacteristicTile_3> createState() => _CharacteristicTile_3State();
}

class _CharacteristicTile_3State extends State<CharacteristicTile_3> {
    IconButton button3Notify = IconButton(
    onPressed: () => {},
    icon: const Icon(null),
  );

  @override
  void initState() {
    debugPrint('air_purifier_widget_3: initState()');
    Timer(const Duration(milliseconds: 2000), () {
      button3Notify.onPressed?.call();
      debugPrint('air_purifier_widget_3: onNotificationPressed after 3 seconds!');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: widget.characteristic.value,
      initialData: widget.characteristic.lastValue,
      builder: (c, snapshot) {
      

      // Timer values: OFF / 15 min / 30 min / 60 min / 2h / 4h / 8h  
      if(widget.characteristic.uuid.toString() == '00035b03-58e6-07dd-021a-08123a000303'){
        final value = snapshot.data;
        // debugPrint('air_purifier_widget_3: snapshot.data = $value');
          if(value.toString() == '[]'){ // case 1: not loaded
          return Column(
          children: [
          button3Notify = IconButton(
            onPressed: widget.onNotificationPressed,
            tooltip: 'Timer Settings: OFF / 15min / 30min / 1h / 2h / 4h / 8h',
            iconSize: 75,
            splashRadius: 1,
            icon: Image.asset(
            'assets/images/air_purifier/timer_color.png',
            color: Colors.black.withOpacity(0.8),
            colorBlendMode: BlendMode.darken,
            ),
          ),
          const Text(
          'Click to Monitor \n& Set Timer',
          style: TextStyle(fontSize: 10,color: Colors.white),
          textAlign: TextAlign.center,
          ),
          ],
        );
      } else if (value.toString() == '[0]'){ // case 2: timer = OFF
        globals.timerCounter = 0;
        // debugPrint('air_purifier_widget_1: globals.timerCounter = ${globals.timerCounter}');
          return Column(
            children: [
            IconButton(
              onPressed: widget.onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/timer_color.png',
              ),
              iconSize: 75,
            ),
            const Text(
            'Timer: OFF',
            style: TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      } 
      else if (value.toString() == '[60]'){ // case 5: timer = 1 hours
        globals.timerCounter = 1;
        // debugPrint('air_purifier_widget_1: globals.timerCounter = ${globals.timerCounter}');
          return Column(
            children: [
            IconButton(
              onPressed: widget.onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/timer_color.png',
              ),
              iconSize: 75,
            ),
            const Text(
            'Timer: 1 h',
            style: TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      else if (value.toString() == '[2]'){ // case 6: timer = 2 hours
        globals.timerCounter = 2;
        // debugPrint('air_purifier_widget_1: globals.timerCounter = ${globals.timerCounter}');
          return Column(
            children: [
            IconButton(
              onPressed: widget.onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/timer_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Timer: ${value.toString().replaceAll('[', '').replaceAll(']', '')} h',
            style: const TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      else if (value.toString() == '[4]'){ // case 7: timer = 4 hours
        globals.timerCounter = 3;
        // debugPrint('air_purifier_widget_1: globals.timerCounter = ${globals.timerCounter}');
          return Column(
            children: [
            IconButton(
              onPressed: widget.onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/timer_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Timer: ${value.toString().replaceAll('[', '').replaceAll(']', '')} h',
            style: const TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      else if (value.toString() == '[8]'){ // case 8: timer = 8 hours
        globals.timerCounter = 4;
        // debugPrint('air_purifier_widget_1: globals.timerCounter = ${globals.timerCounter}');
          return Column(
            children: [
            IconButton(
              onPressed: widget.onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/timer_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Timer: ${value.toString().replaceAll('[', '').replaceAll(']', '')} h',
            style: const TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      else {
        return Column(
            children: [
            IconButton(
              onPressed: widget.onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/timer_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Timer error: ${value.toString().replaceAll('[', '').replaceAll(']', '')}',
            style: const TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      } else {
        return Column();
      }
      },
    );
  }
}