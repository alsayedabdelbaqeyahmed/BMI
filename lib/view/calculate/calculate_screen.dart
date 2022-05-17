// ignore_for_file: prefer_const_declarations, unnecessary_string_interpolations

import 'dart:math';

import 'package:bmi_app/model/constants/animated_page-route.dart';
import 'package:bmi_app/model/constants/result_text.dart';

import 'package:bmi_app/view/calculate/collect_weight_tall.dart';

import 'package:flutter/material.dart';

import 'chose_button.dart';

class CalculateScreen extends StatefulWidget {
  static const String routeNames = '/routeName';
  const CalculateScreen({Key? key}) : super(key: key);

  @override
  _CalculateScreenState createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  String? age;
  String? weight;
  String? tall;

  String? result = '0.0';

  String? resultBmi() {
    if (tall?.trim() != null &&
        weight?.trim() != null &&
        weight!.isNotEmpty &&
        tall!.isNotEmpty) {
      final reweight = double.tryParse(weight!);
      final retall = double.tryParse(tall!);
      final tallWithMeter = retall! / 100;

      final bmi = reweight! / pow(tallWithMeter, 2);

      result = bmi.toStringAsFixed(1);
      return result;
    } else {
      return result;
    }
  }

  @override
  void initState() {
    resultBmi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: LayoutBuilder(builder: (context, constrain) {
        return Container(
          padding: EdgeInsetsDirectional.only(
            top: size.height * 0.01,
          ),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/spalsh_screen_back1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: size.width * 0.04,
                      end: size.width * 0.04,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'BMI Calculator',
                          style: TextStyle(
                            color: const Color(0xffE0F2F1),
                            fontSize: size.width * 0.09,
                          ),
                        ),
                        SizedBox(width: size.width * 0.005),
                        IconButton(
                          onPressed: () async {
                            Navigator.of(context).pushAndRemoveUntil(
                              AnimatedPageRoute(
                                beginDx: 10.0,
                                beginDy: 10.0,
                                endDx: 0.0,
                                endDy: 0.0,
                                duration: const Duration(seconds: 0),
                                curve: Curves.ease,
                                widget: const CalculateScreen(),
                              ),
                              (_) => false,
                            );
                          },
                          icon: Image.asset(
                            'assets/images/refresh_btn.png',
                            width: size.width * 0.2,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  ChoseTypeButton(
                    constraints: constrain,
                  ),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CollectWeightTall(
                        width: constrain.maxWidth * 0.3,
                        hintText: '20',
                        lableText: 'age',
                        save: (value) async {
                          //  print(value);
                          age = value;
                          resultBmi();
                          setState(() {});
                        },
                        onFieldSubmitted: (value) async {
                          age = value;
                          resultBmi();
                          setState(() {});
                        },
                        onChanged: (value) async {
                          age = value;
                          resultBmi();
                          setState(() {});
                        },
                      ),
                      CollectWeightTall(
                        width: constrain.maxWidth * 0.3,
                        hintText: 'Kg',
                        lableText: 'weight',
                        save: (value) async {
                          weight = value;
                          resultBmi();
                          setState(() {});
                        },
                        onFieldSubmitted: (value) async {
                          weight = value;
                          resultBmi();
                          setState(() {});
                        },
                        onChanged: (value) async {
                          weight = value;

                          resultBmi();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Center(
                    child: CollectWeightTall(
                      width: constrain.maxWidth * 0.3,
                      hintText: 'Cm',
                      lableText: 'height',
                      save: (value) async {
                        tall = value;
                        resultBmi();
                        setState(() {});
                      },
                      onFieldSubmitted: (value) async {
                        tall = value;

                        resultBmi();
                        setState(() {});
                      },
                      onChanged: (value) async {
                        tall = value;

                        resultBmi();
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: constrain.maxHeight * 0.04),
                  Stack(
                    children: [
                      Image.asset('assets/images/bmi4.png'),
                      Positioned(
                        child: resultText(result: result, constr: constrain),
                        // left: 20,
                        bottom: constrain.heightConstraints().maxHeight * 0.02,
                        right: result != '0.0'
                            ? constrain.widthConstraints().maxWidth > 392
                                ? constrain.widthConstraints().maxWidth * 0.4
                                : constrain.widthConstraints().maxWidth * 0.425
                            : constrain.widthConstraints().maxWidth * 0.44,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
