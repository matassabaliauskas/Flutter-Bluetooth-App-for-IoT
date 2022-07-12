
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'globals.dart' as globals;
// This widget is for displaying the 4th air purifier function to the air purifier main screen: temperature icon and temperature value
// Service UUID: 00035b03-58e6-07dd-021a-08123a000300
// Characteristic UUID: 00035b03-58e6-07dd-021a-08123a000304

class ServiceTile_4 extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile_4> characteristicTiles;

  const ServiceTile_4(
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

class CharacteristicTile_4 extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;
  final VoidCallback? onNotificationPressed;

  const CharacteristicTile_4(
      {Key? key,
      required this.characteristic,
      this.onReadPressed,
      this.onWritePressed,
      this.onNotificationPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
      
        
      if(characteristic.uuid.toString() == '00035b03-58e6-07dd-021a-08123a000304'){
        // final snapshotData = '[0, 50, 54]';
        final snapshotData = snapshot.data;
        // debugPrint('air_purifier_widget_4: snapshot.data = $snapshotData');

        late int temperatureValueDecimal1;
        late double valueCelsiusDouble;
        late double valueFahrenheitDouble;

        if (snapshotData.toString() == '[]'){
          temperatureValueDecimal1 = -1;
          valueCelsiusDouble = (double.tryParse(temperatureValueDecimal1.toString()) ?? -1);
          valueFahrenheitDouble = double.parse(((valueCelsiusDouble * 1.8) + 32).toStringAsFixed(1));
        }
        else if(snapshotData.toString() != '[]'){
          List<String> splitSnapshotData = snapshotData.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
          
          // deal with scenario when only 3 out of 4 bytes are sent (e.g. snapshotData = [0, 50, 54])
          if(splitSnapshotData.length == 3){
            splitSnapshotData.add('0');
            // debugPrint('air_purifier_widget_4: new splitSnapshotData: $splitSnapshotData');
          }

          final Map<int, String> temperatureValues = {
          for (int i = 0; i < splitSnapshotData.length; i++)
              i: splitSnapshotData[i]
          };

          int temperatureValueDecimal1 = int.tryParse(temperatureValues[0].toString()) ?? -1;
          String temperatureValueInt1 = String.fromCharCode(temperatureValueDecimal1); // either P or N

          int temperatureValueDecimal2 = int.tryParse(temperatureValues[1].toString()) ?? -1;
          int temperatureValueInt2 = int.tryParse(String.fromCharCode(temperatureValueDecimal2)) ?? 0;
          
          int temperatureValueDecimal3 = int.tryParse(temperatureValues[2].toString()) ?? -1;
          int temperatureValueInt3 = int.tryParse(String.fromCharCode(temperatureValueDecimal3)) ?? 0;

          int temperatureValueDecimal4 = int.tryParse(temperatureValues[3].toString()) ?? -1;
          int temperatureValueInt4 = int.tryParse(String.fromCharCode(temperatureValueDecimal4)) ?? 0;


          String temperatureString = '';
          if(temperatureValueInt1 == 'P'){
            temperatureString = temperatureValueInt2.toString() + temperatureValueInt3.toString() + '.' + temperatureValueInt4.toString();
          } else if(temperatureValueInt1 == 'N'){
            temperatureString = '-' + temperatureValueInt2.toString() + temperatureValueInt3.toString() + '.' + temperatureValueInt4.toString();
          }
          
          //debugPrint('air_purifier_widget_4: temperature decimal values are: $temperatureValueDecimal1, $temperatureValueDecimal2, $temperatureValueDecimal3, $temperatureValueDecimal4');
          //debugPrint('air_purifier_widget_4: temperature integer values are: $temperatureValueInt1, $temperatureValueInt2, $temperatureValueInt3, $temperatureValueInt4');
          //debugPrint('air_purifier_widget_4: temperatureString = $temperatureString');
          
          valueCelsiusDouble = (double.tryParse(temperatureString) ?? -1);
          valueFahrenheitDouble = double.parse(((valueCelsiusDouble * 1.8) + 32).toStringAsFixed(1));
          debugPrint('air_purifier_widget_4: valueCelsiusDouble = $valueCelsiusDouble');
          debugPrint('air_purifier_widget_4: valueFahrenheitDouble = $valueFahrenheitDouble');
        }


        if(valueCelsiusDouble == -1 || snapshotData.toString() == '[]') { // case 1: default case where no data is loaded
          return Column(
            children: [
            IconButton(
              onPressed: onNotificationPressed,
              iconSize: 75,
              // splashRadius: 1,
              icon: Image.asset(
              'assets/images/air_purifier/temperature_color.png',
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
      } else if(valueCelsiusDouble.toString() != '[]' && globals.temperatureState == 0) { // case 2: celsius
          return Column(
            children: [
            IconButton(
              onPressed: onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/temperature_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Temperature: $valueCelsiusDouble °C',
            style: const TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      } 
      else if(valueCelsiusDouble.toString() != '[]' && globals.temperatureState == 1) { // case 3: fahrenheit
          return Column(
            children: [
            IconButton(
              onPressed: onWritePressed,
              icon: Image.asset(
              'assets/images/air_purifier/temperature_color.png',
              ),
              iconSize: 75,
            ),
            Text(
            'Temperature: $valueFahrenheitDouble °F',
            style: const TextStyle(fontSize: 10,color: Colors.white),
            ),
            ],
          );
      } 
      else {
        return Column();
      }
      } else {
        return Column();
      }
      },
    );
  }
}