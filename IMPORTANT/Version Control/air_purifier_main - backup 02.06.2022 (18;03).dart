// This is my own test widget to control the air purifier
// main function

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'air_purifier_widget_1.dart';
import 'air_purifier_widget_2.dart';
import 'air_purifier_widget_3.dart';
import 'air_purifier_widget_4.dart';
import 'air_purifier_widget_5.dart';
import 'globals.dart' as globals;

class AirPurifierMain extends StatelessWidget {
  const AirPurifierMain({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;
  final List<int>  fanArray = const [0x00,0x19,0x32,0x4B,0x64, 0xA1]; // 0% | 25% | 50% | 75% | 100% | AUTO
  final List<int>  plasmaArray = const [0xB0,0xB1]; // OFF | ON 
  final List<int>  timerArray = const [0x00,0x0F,0x1E,0x01,0x02,0x04,0x08]; // OFF | 15min | 30min | 1h | 2h | 4h | 8h

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(100),
      math.nextInt(300)
    ];
  }

  List<int> _toggleFanArray(List<int> array) {
    final fanArray = array;

    if(globals.fanCounter == 5){
      globals.fanCounter = 0;
      //debugPrint('air_purifier_main: globals.fanCounter = ${globals.fanCounter}');
      return [
      fanArray[globals.fanCounter],
      ];
    } 
    else {
      globals.fanCounter = globals.fanCounter + 1;
      //debugPrint('air_purifier_main: globals.fanCounter = ${globals.fanCounter}');
      return [
      fanArray[globals.fanCounter],
      ];
    }
  }

  List<int> _togglePlasmaArray(List<int> array) {
    final plasmaArray = array;

    if(globals.plasmaCounter == 1){
      globals.plasmaCounter = 0;
      debugPrint('air_purifier_main: globals.plasmaCounter = ${globals.plasmaCounter}');
      return [
      plasmaArray[globals.plasmaCounter],
      ];
    } 
    else {
      globals.plasmaCounter = globals.plasmaCounter + 1;
      debugPrint('air_purifier_main: globals.plasmaCounter = ${globals.plasmaCounter}');
      return [
      plasmaArray[globals.plasmaCounter],
      ];
    }
  }

  List<int> _toggleTimerArray(List<int> array) {
    final timerArray = array;

    if(globals.timerCounter == 6){
      globals.timerCounter = 0;
      // debugPrint('air_purifier_main: globals.timerCounter = ${globals.timerCounter}');
      return [
      timerArray[globals.timerCounter],
      ];
    } 
    else {
      globals.timerCounter = globals.timerCounter + 1;
      // debugPrint('air_purifier_main: globals.timerCounter = ${globals.timerCounter}');
      return [
      timerArray[globals.timerCounter],
      ];
    }
  }





  
  // _buildServiceTiles_1 = Fan Widget
  List<Widget> _buildServiceTiles_1(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile_1(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile_1(
                    characteristic: c,
                    onReadPressed: () => {c.read()},
                    onWritePressed: () async {
                      await c.write(_toggleFanArray(fanArray));
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }


    // _buildServiceTiles_2 = Plasma Widget
  List<Widget> _buildServiceTiles_2(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile_2(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile_2(
                    characteristic: c,
                    onReadPressed: () => {c.read()},
                    onWritePressed: () async {
                      await c.write(_togglePlasmaArray(plasmaArray));
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

      // _buildServiceTiles_3 = Timer Widget
  List<Widget> _buildServiceTiles_3(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile_3(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile_3(
                    characteristic: c,
                    onReadPressed: () => {c.read()},
                    onWritePressed: () async {
                      await c.write(_toggleTimerArray(timerArray));
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

      // _buildServiceTiles_4 = Temperature Widget
  List<Widget> _buildServiceTiles_4(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile_4(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile_4(
                    characteristic: c,
                    onReadPressed: () => {c.read()},

                    onWritePressed: () => {
                      if (globals.temperatureState == 0){
                        globals.temperatureState = 1,
                        // debugPrint('air_purifier_main: temperatureState = ${globals.temperatureState}'),
                        c.read(),
                      }
                      else if (globals.temperatureState == 1){
                        globals.temperatureState = 0,
                        // debugPrint('air_purifier_main: temperatureState = ${globals.temperatureState}'),
                        c.read(),
                      } else {}
                    },

                    onNotificationPressed: () async {
                      if (globals.temperatureState == 0){
                        globals.temperatureState = 1;
                        debugPrint('air_purifier_main: temperatureState = ${globals.temperatureState}');
                        await c.setNotifyValue(!c.isNotifying);
                        await c.read();
                      }
                      else if (globals.temperatureState == 1){
                        globals.temperatureState = 0;
                        debugPrint('air_purifier_main: temperatureState = ${globals.temperatureState}');
                        await c.setNotifyValue(!c.isNotifying);
                        await c.read();
                      } else {} 
                    },
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }


      // _buildServiceTiles widget is required to send and write data
  List<Widget> _buildServiceTiles_5(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile_5(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile_5(
                    characteristic: c,
                    onReadPressed: () => {c.read()},
                    onWritePressed: () async {
                      await c.write(_getRandomBytes());
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }







  // A widget for the AppBar and device status
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color of the whole air purifier app
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        //shadowColor: Colors.lightBlue,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(device.name),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
            ),
          ],
        ),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return TextButton(
                  onPressed: onPressed,
                  child: Text(text),
                  style: TextButton.styleFrom(
                    primary: Colors.orange,
                    alignment: Alignment.center,
                    fixedSize: const Size.fromWidth(105),
                  ));
            },
          )
        ],
      ),

      // the actual main body of the air purifier app
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? const Icon(
                        Icons.bluetooth_connected,
                        color: Colors.lightBlue,
                      )
                    : const Icon(
                        Icons.bluetooth_disabled,
                        color: Colors.lightBlue,
                      ),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                textColor: Colors.white,
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        onPressed: () => device.discoverServices(),
                      ),
                      const IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),

            Column(
              children: [
                // 1st Row: Fan Speed and Plasma
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 1st function: Fan (reading and writing value)
                    StreamBuilder<List<BluetoothService>>(
                      stream: device.services,
                      initialData: const [],
                      builder: (c, snapshot) {
                        return Column(
                          children: _buildServiceTiles_1(snapshot.data!),
                        );
                      },
                    ),

                    // 2nd function: Plasma (reading and writing value)
                    StreamBuilder<List<BluetoothService>>(
                      stream: device.services,
                      initialData: const [],
                      builder: (c, snapshot) {
                        return Row(
                          children: _buildServiceTiles_2(snapshot.data!),
                        );
                      },
                    ),
                    
                  ],
                ),
                const SizedBox(height: 50),
                // 2nd Row: Timer and Temperature
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 3rd function: Timer (writing and reading value)
                    StreamBuilder<List<BluetoothService>>(
                      stream: device.services,
                      initialData: const [],
                      builder: (c, snapshot) {
                        return Column(
                          children: _buildServiceTiles_3(snapshot.data!),
                        );
                      },
                    ),

                    // 4th function: Plasma (only reading value)
                    StreamBuilder<List<BluetoothService>>(
                      stream: device.services,
                      initialData: const [],
                      builder: (c, snapshot) {
                        return Row(
                          children: _buildServiceTiles_4(snapshot.data!),
                        );
                      },
                    ),
                    
                  ],
                ),

                const SizedBox(height: 50),

                // 3rd Row: Air Quality Graph...
                // Make this screen wide... use an actual graph with data...
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<List<BluetoothService>>(
                      stream: device.services,
                      initialData: const [],
                      builder: (c, snapshot) {
                        return Row(
                          children: _buildServiceTiles_5(snapshot.data!),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
