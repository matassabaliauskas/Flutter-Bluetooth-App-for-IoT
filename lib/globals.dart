// Widget 1: Fan 
// default = -1
// OFF: fanCounter = 0
// AUTO: fanCounter = 1
// 25: fanCounter = 2
// 50: fanCounter = 3
// 75: fanCounter = 4
// 100: fanCounter = 5
int fanCounter =  -1;

// Widget 2: Plasma
// default = -1
// OFF: plasmaCounter = 0
// ON: plasmaCounter = 1
int plasmaCounter = -1;

// Widget 3: Timer
// default = -1
// OFF: timerCounter = 0
// 1h: timerCounter = 1
// 2h: timerCounter = 2
// 4h: timerCounter = 3
// 8h: timerCounter = 4
int timerCounter = -1;

// Widget 4: Temperature
// temperatureState = 0 means Celsius
// temperatureState = 1 means Fahrenheit
int temperatureState = 1; // default Celsius

// Widget 5: PM2.5 and PM10 data array
// It should include time, PM2.5, PM10
List<double> airSensorValue1Array = <double>[];
List<double> airSensorValue2Array = <double>[];

int airSensorYear = 0;
int airSensorMonth = 0;
int airSensorDay = 0;
List<String> airSensorHourArray = <String>[];
List<String> airSensorMinuteArray = <String>[];
List<String> airSensorSecondArray = <String>[];
int airSensorValueCounter = 0;
int airSensorValueFlag = 0;
int airSensorSleepingFlag = 0; // Flag to indicate whether air purifier is in sleeping mode