// ignore_for_file: prefer_const_declarations, unnecessary_string_interpolations

import 'package:bmi_app/model/constants/result_text.dart';
import 'package:bmi_app/model/dataModel/data_model.dart';
import 'package:bmi_app/model/dataModel/local_data_base.dart';

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
  final dataModel = LocalDataBase.db;
  DataModel? data;

  String? age;
  String? weight;
  String? tall;

  Future<DataModel> localUserData() async {
    // var db = LocalDataBase.db;

    await dataModel.getUserData().then((value) {
      data = value;
    });

    return data!;
  }

  Future getDataBase(DataModel data) async {
    var db = LocalDataBase.db;
    await db.inserData(data);
  }

  String? result = '0.0';

  String? resultBmi() {
    if (data?.tallValues?.trim() != null &&
        data?.weightValues?.trim() != null &&
        data!.weightValues!.isNotEmpty &&
        data!.tallValues!.isNotEmpty) {
      final weight = double.tryParse(data!.weightValues!);
      final tall = double.tryParse(data!.tallValues!);
      final tallWithMeter = tall! / 100;

      final bmi = weight! / (tallWithMeter * tallWithMeter);

      result = bmi.toStringAsFixed(1);
      return result;
    } else {
      return result;
    }
  }

  @override
  void initState() {
    localUserData().then((value) {
      setState(() {});
      resultBmi();
    });

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
                          await onsaved();
                        },
                        onFieldSubmitted: (value) async {
                          age = value;
                          await onsaved();
                          // setState(() {});
                        },
                        onChanged: (value) async {
                          age = value;
                          await onsaved();
                          // setState(() {});
                        },
                      ),
                      CollectWeightTall(
                        width: constrain.maxWidth * 0.3,
                        hintText: 'Kg',
                        lableText: 'weight',
                        save: (value) async {
                          weight = value;
                          await onsaved();
                          // print(value);
                        },
                        onFieldSubmitted: (value) async {
                          weight = value;
                          await onsaved();

                          //  setState(() {});
                        },
                        onChanged: (value) async {
                          weight = value;

                          await onsaved();
                          //  setState(() {});
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
                        // print(value);

                        await onsaved();
                      },
                      onFieldSubmitted: (value) async {
                        tall = value;

                        await onsaved();
                        //  setState(() {});
                      },
                      onChanged: (value) async {
                        tall = value;

                        await onsaved();
                        //  setState(() {});
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

  Future onsaved() async {
    await getDataBase(
      DataModel(
        tallValues: tall,
        weightValues: weight,
        ageValues: age,
      ),
    ).then(
      (value) async {
        await localUserData().then((value) {
          setState(() {});
          resultBmi();
        });
      },
    );
  }
}
