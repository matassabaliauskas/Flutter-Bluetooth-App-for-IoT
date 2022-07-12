// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// BluetoothFlutterPlus modifications done by Matas Sabaliauskas
// Project: Air Purifier (3logytech)

// Modules used: [main.dart], [widgets.dart], [air_purifier_main.dart], [air_purifier_led.dart]

import 'dart:async';
import 'dart:io';
//import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'widgets.dart';
import 'air_purifier_main.dart';

// Main function: do not touch
void main() {
  runApp(const FlutterBlueApp());
}

// Flutter Blue setup: do not touch
class FlutterBlueApp extends StatelessWidget {
  const FlutterBlueApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBluePlus.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return const FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
}

// 1st Screen: Bluetooth Off Status
class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.20,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/trilogy_logo.png',
              fit: BoxFit.fitHeight,
              height: 50,
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
              child: const Text('Connect To Bluetooth'),
              width: double.infinity,
              alignment: Alignment.center,
            )
          ],
        ),
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // vertical center
          crossAxisAlignment: CrossAxisAlignment.center, // horizontal center
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Icon(
              Icons.bluetooth_disabled,
              size: MediaQuery.of(context).size.height * 0.20,
              color: Colors.white54,
            ),

            // const SizedBox(
            //   height: 150,
            // ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text('TURN ON'),
              ),
              onPressed: Platform.isAndroid
                  ? () => FlutterBluePlus.instance.turnOn()
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// 2nd Screen: Bluetooth On, Connect Device widget
class FindDevicesScreen extends StatelessWidget {
  const FindDevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color of the whole body of the widget below the AppBar
      backgroundColor: Colors.black,
      appBar: AppBar(
        //toolbarHeight: 120,
        toolbarHeight: MediaQuery.of(context).size.height * 0.20,
        backgroundColor: Colors.black, // color of the AppBar
        //shadowColor: Colors.lightBlue,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/trilogy_logo.png',
              fit: BoxFit.fitHeight,
              height: 50,
            ),
            Container(
              //padding: const EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
              child: const Text('Connect Your Device'),
              width: double.infinity,
              alignment: Alignment.center,
            )
          ],
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () => FlutterBluePlus.instance
            .startScan(timeout: const Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(const Duration(seconds: 2))
                    .asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
                initialData: const [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                            // This is the name of the already connected device
                            textColor: Colors.white,
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return ElevatedButton(
                                    child: const Text('CONNECT'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.orange,
                                    ),

                                    // onPressed: takes you to another page when device is already connected
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      d.connect();
                                      d.discoverServices(); // can include this if I want to automatically discover services
                                      return AirPurifierMain(device: d);
                                    })),
                                  );
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),

              // onTap: allows to connect to the device for the first time
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBluePlus.instance.scanResults,
                initialData: const [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            r.device.discoverServices(); // can include this if I want to automatically discover services                          
                            return AirPurifierMain(device: r.device);
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBluePlus.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton.extended(
              icon: const Icon(Icons.stop),
              label: const Text('STOP'),
              backgroundColor: Colors.red,
              onPressed: () => FlutterBluePlus.instance.stopScan(),
            );
          } else {
            return FloatingActionButton.extended(
                icon: const Icon(Icons.search, color: Colors.white),
                label: const Text('SCAN'),
                backgroundColor: Colors.orange,
                onPressed: () => FlutterBluePlus.instance
                    .startScan(timeout: const Duration(seconds: 4)));
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}