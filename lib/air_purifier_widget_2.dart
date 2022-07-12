// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'globals.dart' as globals;
// This widget is for displaying the 2nd air purifier function to the air purifier main screen: plasma icon and plasma status
// Service UUID: 00035b03-58e6-07dd-021a-08123a000300
// Characteristic UUID: 00035b03-58e6-07dd-021a-08123a000302

class ServiceTile_2 extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile_2> characteristicTiles;

  const ServiceTile_2(
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

class CharacteristicTile_2 extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;
  final VoidCallback? onNotificationPressed;

  const CharacteristicTile_2(
      {Key? key,
      required this.characteristic,
      this.onReadPressed,
      this.onWritePressed,
      this.onNotificationPressed})
      : super(key: key);

  @override
  State<CharacteristicTile_2> createState() => _CharacteristicTile_2State();
}

class _CharacteristicTile_2State extends State<CharacteristicTile_2> {
  IconButton button2Notify = IconButton(
    onPressed: () => {},
    icon: const Icon(null),
  );

  @override
  void initState() {
    debugPrint('air_purifier_widget_2: initState()');
    Timer(const Duration(milliseconds: 1500), () {
      button2Notify.onPressed?.call();
      debugPrint('air_purifier_widget_2: onNotificationPressed after 2 seconds!');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: widget.characteristic.value,
      initialData: widget.characteristic.lastValue,
      builder: (c, snapshot) {
      
        
      // Plasma values: OFF / ON  
      if(widget.characteristic.uuid.toString() == '00035b03-58e6-07dd-021a-08123a000302'){
        final value = snapshot.data;
        // debugPrint('air_purifier_widget_2: snapshot.data = $value');
        if(value.toString() == '[]'){
          return Column(
            children: [
            button2Notify = IconButton(
              onPressed: widget.onNotificationPressed,
              tooltip: 'Warning: Plasma Ion only turns ON when fan is not OFF!',
              iconSize: 75,
              splashRadius: 1,
              icon: Image.asset(
              'assets/images/air_purifier/plasma_color.png',
              color: Colors.black.withOpacity(0.8),
              colorBlendMode: BlendMode.darken,
              ),

            ),
            const Text(
            'Click to Monitor \n& Control Plasma Ion',
            style: TextStyle(fontSize: 10,color: Colors.white),
            textAlign: TextAlign.center,
            ),
            ],
          );
      } else if(value.toString() == '[177]'){ // Plasma: ON
          globals.plasmaCounter = 1;
          // debugPrint('air_purifier_widget_2: globals.plasmaCounter = ${globals.plasmaCounter}');
          return Column(
            children: [
            IconButton(
              onPressed: widget.onWritePressed,
              //splashRadius: 1,
              icon: Image.asset(
              'assets/images/air_purifier/plasma_color.png',
              ),
              iconSize: 75,
            ),
            const Text(
           'Plasma: ON',
            style: TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      } else if (value.toString() == '[176]') { // Plasma: OFF
        globals.plasmaCounter = 0;
        // debugPrint('air_purifier_widget_2: globals.plasmaCounter = ${globals.plasmaCounter}');
        return Column(
            children: [
            IconButton(
              onPressed: widget.onWritePressed,
              splashRadius: 1,
              icon: Image.asset(
              'assets/images/air_purifier/plasma_color.png',
              ),
              iconSize: 75,
            ),
            const Text(
            'Plasma: OFF',
            style: TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      } else {
        return Column(
          children: [
            IconButton(
              onPressed: widget.onWritePressed,
              splashRadius: 1,
              icon: Image.asset(
              'assets/images/air_purifier/plasma_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Plasma error: ${value.toString().replaceAll('[', '').replaceAll(']', '')}',
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