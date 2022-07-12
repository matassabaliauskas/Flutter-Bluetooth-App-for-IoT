// This is my own test widget to control the air purifier
// air purifier LED control function

// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert' show utf8;
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AirPurifierLed extends StatefulWidget {
  const AirPurifierLed({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  State<AirPurifierLed> createState() => _AirPurifierLedState();
}

class _AirPurifierLedState extends State<AirPurifierLed> {
  // Bluetooth chip specific service and characteristic UUIDs
  //final String SERVICE_UUID = "00035b03-58e6-07dd-021a-08123a000300";
  //final String CHARACTERISTIC_UUID = "00035b03-58e6-07dd-021a-08123a000301";
  
  final String SERVICE_UUID = "00035b03-58e6-07dd-021a-08123a000300";
  final String CHARACTERISTIC_UUID = "00035b03-58e6-07dd-021a-08123a000301";
  bool isReady = false;
  Stream<List<int>>? stream;

  @override
  void initState() {
    super.initState();
    isReady = false;
    connectToDevice();
    //discoverServices();
  }

  // Disabling this function makes it work very fast but it only assumes that device is already connected
  connectToDevice() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    
    Timer(const Duration(seconds: 1), () {
      if (!isReady) {
        disconnectFromDevice();
        _Pop();
      }
    });

    //await widget.device.connect(); // this is where the bug was!
    discoverServices();
  }

  disconnectFromDevice() {
    if (widget.device == null) {
      _Pop();
      return;
    }
    widget.device.disconnect();
  }

  _Pop() {
    Navigator.of(context).pop(true);
  }

  String _dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  discoverServices() async {
    if (widget.device == null) {
      _Pop();
      return;
    }
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      //debugPrint('service uuid: ${service.uuid.toString()}\n');
      //debugPrint('service characteristics: ${service.characteristics.toString()}\n');

      if (service.uuid.toString() == SERVICE_UUID) {
        service.characteristics.forEach((characteristic) {  
          //debugPrint('characteristic uuid: ${characteristic.uuid.toString()}\n');

          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            characteristic.setNotifyValue(!characteristic.isNotifying);
            stream = characteristic.value;
            setState(() {
              isReady = true;
              debugPrint('device status: isReady = true');
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String return_led_value = '';
    return Scaffold(
      body: !isReady
          ? Center(
              child: IconButton(
                icon: SizedBox(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.grey),
                  ),
                  width: 18.0,
                  height: 18.0,
                ),
                onPressed: null,
              ),
            )
          : Container(
              //body: Container(
              child: StreamBuilder<List<int>>(
                  stream: stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<int>> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.active) {
                      var currentValue = _dataParser(snapshot.data!);
                      debugPrint('air_purifier_led.dart: currentValue is: ${currentValue}\n\n');
                      if (currentValue == 'G') {
                        setState(() {
                          return_led_value = currentValue;
                          debugPrint("setState successful!: return_led_value = ${return_led_value}");
                        });
                        return const Scaffold(
                            body: Center(
                                child: Text(
                          'Green LED: ON',
                          style: TextStyle(color: Colors.green),
                        )));
                      } else {
                        return const Scaffold(
                            body: Center(
                          child: Text(
                            'Green LED: OFF',
                            style: TextStyle(color: Colors.green),
                          ),
                        ));
                      }
                    } else {
                      return const Text("Error!");
                    }
                  }),
            ),
    );
  }
}
