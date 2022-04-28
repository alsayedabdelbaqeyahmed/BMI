import 'package:bmi_app/model/constants/result_text.dart';
import 'package:bmi_app/view/calculate/chose_button.dart';
import 'package:bmi_app/view/calculate/collect_weight_tall.dart';
import 'package:flutter/material.dart';

class CalculateWebResult extends StatefulWidget {
  const CalculateWebResult({Key? key}) : super(key: key);

  @override
  State<CalculateWebResult> createState() => _CalculateWebResultState();
}

class _CalculateWebResultState extends State<CalculateWebResult> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  double? age = 0;
  double? weight = 0;
  double? height = 100;
  String? result = '0';
  String resultBMi() {
    final heightWithMeter = height! / 100;

    final bmi = weight! / (heightWithMeter * heightWithMeter);

    result = bmi.toStringAsFixed(1);
    setState(() {});
    return result!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrain) {
        return Container(
          padding: EdgeInsetsDirectional.only(top: constrain.maxHeight * 0.02),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/spalsh_screen_back1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ChoseTypeButton(constraints: constrain),
                SizedBox(height: constrain.maxHeight * 0.2),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          CollectWeightTall(
                            width: constrain.maxWidth * 0.5,
                            hintText: '20',
                            lableText: 'Age',
                            onFieldSubmitted: (value) {
                              age = double.tryParse(value);
                              resultBMi();
                            },
                            save: (value) {
                              age = double.tryParse(value!);
                              resultBMi();
                            },
                          ),
                          SizedBox(height: constrain.maxHeight * 0.1),
                          CollectWeightTall(
                            width: constrain.maxWidth * 0.5,
                            hintText: '150',
                            lableText: 'Height',
                            onFieldSubmitted: (value) {
                              height = double.tryParse(value);
                              resultBMi();
                            },
                            save: (value) {
                              height = double.tryParse(value!);
                              resultBMi();
                            },
                          ),
                          SizedBox(height: constrain.maxHeight * 0.1),
                          CollectWeightTall(
                            width: constrain.maxWidth * 0.5,
                            hintText: '80',
                            lableText: 'Weight',
                            onFieldSubmitted: (value) {
                              weight = double.tryParse(value);
                              resultBMi();
                            },
                            save: (value) {
                              weight = double.tryParse(value!);
                              resultBMi();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: constrain.maxWidth * 0.1),
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/bmi4.png',
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            child: Center(
                              child: resultText(
                                result: result,
                                constr: constrain,
                              ),
                            ),
                            // left: 20,
                            bottom:
                                constrain.heightConstraints().maxHeight * 0.02,
                            right: result == '0'
                                ? constrain.widthConstraints().maxWidth * 0.35
                                : constrain.widthConstraints().maxWidth * 0.33,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
