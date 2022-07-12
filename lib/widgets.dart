// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

//import 'dart:ffi';
//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// This widget is for outputing the list of available devices to the main dart function
class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap})
      : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.isNotEmpty && result.advertisementData.connectable) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            // Device Name in the device result list
            result.device.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            // Device ID in the device result list
            result.device.id.toString(),
            //style: Theme.of(context).textTheme.caption,
            style: const TextStyle(color: Colors.white),
          )
        ],
      );
    } else if (result.advertisementData.connectable) {
      return Text(
        result.device.id.toString(),
        style: const TextStyle(color: Colors.white),
      );
    } else {
      return Text(
        ("${result.device.id.toString()}\nError! Device can't be connected!"),
        style: const TextStyle(color: Colors.white),
      );
    }
  }

  // Builds connect button and adds the device title
  // In the office: ~40 total devices, only 14 of them are actually connectable...
  // Delete unconnectable devices from the list!
  @override
  Widget build(BuildContext context) {
    if (result.advertisementData.connectable) {
      return ListTile(
        title: _buildTitle(context),
        trailing: ElevatedButton(
          child: const Text('CONNECT'),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white,
          ),
          onPressed: (result.advertisementData.connectable)
              ? onTap
              : null, // Disables unconnectable devices from tapping
        ),
      );
    } else {
      return Container(); // return an empty container if device is unconnectable
    }
  }
}