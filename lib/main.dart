import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
static const batteryChannel = MethodChannel('uniquedomain.com/battery');
String batteryLevel = "Waiting...";

@override
Widget build(BuildContext context) => Scaffold(
  backgroundColor: Colors.black,
  body: Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text(
        batteryLevel,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: getBatteryLevel, 
          child: Text('Get Battery Level')
          ),
    ],
    ),
  ),
);

Future getBatteryLevel() async {

  final int newBatteryLevel = await batteryChannel.invokeMethod('getBatteryLevel');

  setState(() => batteryLevel = '$newBatteryLevel%');
}

}
