// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'globals.dart' as globals;


// This widget is for displaying the 1st air purifier function to the air purifier main screen: fan icon and fan status
// Service UUID: 00035b03-58e6-07dd-021a-08123a000300
// Characteristic UUID: 00035b03-58e6-07dd-021a-08123a000301

class ServiceTile_1 extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile_1> characteristicTiles;

  const ServiceTile_1(
      {Key? key, required this.service, required this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.isNotEmpty) {
      return Column(
        children: characteristicTiles,
      );
    } else {
      return Column();
    }
  }
}

// THIS IS A CHARACTERISTICS TILE
class CharacteristicTile_1 extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;
  final VoidCallback? onNotificationPressed;

  const CharacteristicTile_1(
      {Key? key,
      required this.characteristic,
      this.onReadPressed,
      this.onWritePressed,
      this.onNotificationPressed})
      : super(key: key);

  @override
  State<CharacteristicTile_1> createState() => _CharacteristicTile_1State();
}

// THIS IS A CHARACTERISTICS TILE WIDGET STATE


class _CharacteristicTile_1State extends State<CharacteristicTile_1> {

  IconButton button1Notify = IconButton(
    onPressed: () => {},
    icon: const Icon(null),
  );

  @override
  void initState() {
    debugPrint('air_purifier_widget_1: initState()');
    Timer(const Duration(milliseconds: 1000), () {
      button1Notify.onPressed?.call();
      debugPrint('air_purifier_widget_1: onNotificationPressed after 1 second!');
    });
    //Timer.periodic(const Duration(seconds: 10), updateWidget1);
    super.initState();
  }

  // void updateWidget1(Timer timer){
  //   button1Notify.onPressed?.call();
  //   debugPrint('air_purifier_widget_1: timer => onNotificationPressed');
  // }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: widget.characteristic.value,
      initialData: widget.characteristic.lastValue,
      builder: (c, snapshot) {
        // Fan values: OFF / AUTO / 25% / 50% / 75% / 100%
        if (widget.characteristic.uuid.toString() == '00035b03-58e6-07dd-021a-08123a000301') {
          final value = snapshot.data;
          //debugPrint('air_purifier_widget_1: snapshot.data = $snapshot.data');
          if (value.toString() == '[]') {
            return Column(
              children: [
                button1Notify = IconButton(
                  onPressed: widget.onNotificationPressed,
                  tooltip: 'Fan Speed: OFF / AUTO / 25% / 50% / 75% / 100%',
                  iconSize: 75,
                  splashRadius: 1,
                  icon: Image.asset(
                    'assets/images/air_purifier/fan_color.png',
                    color: Colors.black.withOpacity(0.8),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                const Text(
                  'Click to Monitor \n& Change Fan Speed',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          } else if (value.toString() == '[0]') {
            globals.fanCounter = 0;
            // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
            return Column(
              children: [
                IconButton(
                  onPressed: widget.onWritePressed,
                  icon: Image.asset(
                    'assets/images/air_purifier/fan_color.png',
                  ),
                  iconSize: 75,
                ),
                const Text(
                  'Fan: OFF',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            );
          } else if (value.toString() == '[161]') {
            globals.fanCounter = 1;
            // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
            return Column(
              children: [
                IconButton(
                  onPressed: widget.onWritePressed,
                  icon: Image.asset(
                    'assets/images/air_purifier/fan_color.png',
                  ),
                  iconSize: 75,
                ),
                const Text(
                  'Fan: AUTO',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            );
          } else if (value.toString() == '[25]') {
            globals.fanCounter = 2;
            // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
            return Column(
              children: [
                IconButton(
                  onPressed: widget.onWritePressed,
                  icon: Image.asset(
                    'assets/images/air_purifier/fan_color.png',
                  ),
                  iconSize: 75,
                ),
                const Text(
                  'Fan: 25 %',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            );
          } else if (value.toString() == '[50]') {
            globals.fanCounter = 3;
            // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
            return Column(
              children: [
                IconButton(
                  onPressed: widget.onWritePressed,
                  icon: Image.asset(
                    'assets/images/air_purifier/fan_color.png',
                  ),
                  iconSize: 75,
                ),
                const Text(
                  'Fan: 50 %',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            );
          } else if (value.toString() == '[75]') {
            globals.fanCounter = 4;
            // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
            return Column(
              children: [
                IconButton(
                  onPressed: widget.onWritePressed,
                  icon: Image.asset(
                    'assets/images/air_purifier/fan_color.png',
                  ),
                  iconSize: 75,
                ),
                const Text(
                  'Fan: 75 %',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            );
          } else if (value.toString() == '[100]') {
            globals.fanCounter = 5;
            // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
            return Column(
              children: [
                IconButton(
                  onPressed: widget.onWritePressed,
                  icon: Image.asset(
                    'assets/images/air_purifier/fan_color.png',
                  ),
                  iconSize: 75,
                ),
                const Text(
                  'Fan: 100 %',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                IconButton(
                  onPressed: widget.onWritePressed,
                  icon: Image.asset(
                    'assets/images/air_purifier/fan_color.png',
                  ),
                  iconSize: 75,
                ),
                Text(
                  'Fan error: ${value.toString().replaceAll('[', '').replaceAll(']', '')}',
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
