import 'package:bmi_app/model/constants/constant_data.dart';
import 'package:bmi_app/view/home.dart';
import 'package:bmi_app/view/web_view/calculate_web_result.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'view/calculate/calculate_screen.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calcalutor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Muli',
        inputDecorationTheme: inputDecorationStyle(),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Color(0xFF757575)),
          bodyText2: TextStyle(color: Color(0xFF757575)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LayoutBuilder(
        builder: (context, constrain) {
          return constrain.maxWidth.toInt() >= 600
              ? const Expanded(child: CalculateWebResult())
              : const Home();
        },
      ),
      routes: {
        Home.routeNames: (ctx) => const Home(),
        CalculateScreen.routeNames: (ctx) => const CalculateScreen(),
      },
    );
  }
}
