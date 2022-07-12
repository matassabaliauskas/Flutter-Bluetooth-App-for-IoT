# Flutter-Bluetooth-App-for-IoT
A special thank you to the flutter_blue_plus developer team who are working very hard to adapt bluetooth features with Flutter.

This is the source code for a flutter-based mobile application. Below is a very (very) brief description of how it works.
The functions of this application are to monitor a bluetooth-based IoT/Smart Home device, as well as allow the user to control it. 
In this particular case, the device comes with DC fan, bipolar plasma ion, timer, temperature-sensing, and air-particulate-matter-sensing functions.
The hardware of the device is custom-made, running on Microchip PIC24FJ256DA106-I/PT microprocessor, and uses a Microchip RN4020 BLE bluetooth chip, as well as a lot of other sensors which are interacting with the microprocessor and the BLE. The application compiles and works well on both Android and iOS (tested) devices. 

To adapt this application to a different set of hardware, one would to create bluetooth services and characteristics on a RN4020 (or equivalent) bluetooth chip, to send and receive data. This app can then be used to process, monitor, and modify the data in the characteristics.

Syncfusion was used for this project, to graph air quality data from the sensor in real-time.

The following are the screenshots of this mobile application in action.

-----------------------------------------------------------------------

<img src="https://github.com/matassabaliauskas/Flutter-Bluetooth-App-for-IoT/blob/main/App%20Screenshots/android_home_screen_0.jpg" width="480">

-----------------------------------------------------------------------

<img src="https://github.com/matassabaliauskas/Flutter-Bluetooth-App-for-IoT/blob/main/App%20Screenshots/android_vertical_screen_1.jpg" width="480">

-----------------------------------------------------------------------

<img src="https://github.com/matassabaliauskas/Flutter-Bluetooth-App-for-IoT/blob/main/App%20Screenshots/android_vertical_screen_3.jpg" width="480">

-----------------------------------------------------------------------

<img src="https://github.com/matassabaliauskas/Flutter-Bluetooth-App-for-IoT/blob/main/App%20Screenshots/android_vertical_screen_4.jpg" width="480">

-----------------------------------------------------------------------

<img src="https://github.com/matassabaliauskas/Flutter-Bluetooth-App-for-IoT/blob/main/App%20Screenshots/android_vertical_screen_6.jpg" width="480">

-----------------------------------------------------------------------

<img src="https://github.com/matassabaliauskas/Flutter-Bluetooth-App-for-IoT/blob/main/App%20Screenshots/android_vertical_screen_8.jpg" width="480">

-----------------------------------------------------------------------

<img src="https://github.com/matassabaliauskas/Flutter-Bluetooth-App-for-IoT/blob/main/App%20Screenshots/android_vertical_screen_9.jpg" width="480">

