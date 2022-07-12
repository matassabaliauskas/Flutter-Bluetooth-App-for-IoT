// Widget 1: Fan 
// default = -1
// OFF: fanCounter = 0
// 25: fanCounter = 1
// 50: fanCounter = 2
// 75: fanCounter = 3
// 100: fanCounter = 4
// AUTO: fanCounter = 5

int fanCounter =  -1;

// Widget 2: Plasma
// default = -1
// OFF: plasmaCounter = 0 
// ON: plasmaCounter = 1
int plasmaCounter = -1;

// Widget 3: Timer
// default = -1
// OFF: timerCounter = 0
// 15: timerCounter = 1
// 30: timerCounter = 2
// 1h: timerCounter = 3
// 2h: timerCounter = 4
// 4h: timerCounter = 5
// 8h: timerCounter = 6
int timerCounter = -1;

// Widget 4: Temperature
// temperatureState = 0 means Celsius
// temperatureState = 1 means Fahrenheit
int temperatureState = 1; // default Celsius

// Widget 5: PM2.5 and PM10 data array
// It should include time, PM2.5, PM10
List<double> airSensorValue1Array = <double>[];

int airSensorYear = 0;
int airSensorMonth = 0;
int airSensorDay = 0;
List<String> airSensorHourArray = <String>[];
List<String> airSensorMinuteArray = <String>[];
List<String> airSensorSecondArray = <String>[];
int airSensorValue1Counter = 0;
int airSensorValue1Flag = 0;