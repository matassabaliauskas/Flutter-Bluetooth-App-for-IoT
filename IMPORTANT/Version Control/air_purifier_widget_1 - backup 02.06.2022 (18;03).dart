import 'package:flutter/material.dart';
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
    } 
    else {
      return Container();
    }
  }
}

class CharacteristicTile_1 extends StatelessWidget {
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

  // THIS IS A CHARACTERISTICS TILE
  // Characteristics UUID: 00035b03-58e6-07dd-021a-08123a000301
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
      

      // Fan values: 0% / 25% / 50% / 75% / 100% / AUTO
      if(characteristic.uuid.toString() == '00035b03-58e6-07dd-021a-08123a000301'){
        final value = snapshot.data;
        // debugPrint('air_purifier_widget_1: snapshot.data = $value');
        if(value.toString() == '[]'){
          return Column(
          children: [
          IconButton(            
            onPressed: onNotificationPressed,
            iconSize: 75,
            //splashRadius: 1,
            icon: Image.asset(
            'assets/images/air_purifier/fan_color.png',
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
      else if (value.toString() == '[0]') {
        globals.fanCounter = 0;
        // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
        return Column(
            children: [
            IconButton(
              onPressed: onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/fan_color.png',
              ),
              iconSize: 75,
            ),
            const Text(
            'Fan: OFF',
            style: TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      else if (value.toString() == '[25]') {
        globals.fanCounter = 1;
        // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
        return Column(
            children: [
            IconButton(
              onPressed: onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/fan_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Fan: ${value.toString().replaceAll('[', '').replaceAll(']', '')} %',
            style: const TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      else if (value.toString() == '[50]') {
        globals.fanCounter = 2;
        // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
        return Column(
            children: [
            IconButton(
              onPressed: onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/fan_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Fan: ${value.toString().replaceAll('[', '').replaceAll(']', '')} %',
            style: const TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      else if (value.toString() == '[75]') {
        globals.fanCounter = 3;
        // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
        return Column(
            children: [
            IconButton(
              onPressed: onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/fan_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Fan: ${value.toString().replaceAll('[', '').replaceAll(']', '')} %',
            style: const TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      else if (value.toString() == '[100]') {
        globals.fanCounter = 4;
        // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
        return Column(
            children: [
            IconButton(
              onPressed: onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/fan_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Fan: ${value.toString().replaceAll('[', '').replaceAll(']', '')} %',
            style: const TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      else if (value.toString() == '[161]') {
        globals.fanCounter = 5;
        // debugPrint('air_purifier_widget_1: globals.fanCounter = ${globals.fanCounter}');
        return Column(
            children: [
            IconButton(
              onPressed: onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/fan_color.png',
              ),
              iconSize: 75,
            ),
            const Text(
            'Fan: AUTO',
            style: TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      }
      else {
        return Column(
            children: [
            IconButton(
              onPressed: onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/fan_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Fan error: ${value.toString().replaceAll('[', '').replaceAll(']', '')}',
            style: const TextStyle(fontSize: 10,color: Colors.white),
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