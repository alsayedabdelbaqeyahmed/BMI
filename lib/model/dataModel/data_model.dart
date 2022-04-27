import 'package:bmi_app/model/constants/constant_data.dart';

class DataModel {
  String? tallValues;
  String? weightValues;
  String? ageValues;

  DataModel({
    this.ageValues,
    this.tallValues,
    this.weightValues,
  });

  Map<String, dynamic> toJason() {
    return {
      conuserAge!: ageValues,
      conuserTall!: tallValues,
      conuserWeight!: weightValues,
    };
  }

  DataModel.fromJason(Map<String, dynamic> map) {
    ageValues = map[conuserAge];
    tallValues = map[conuserTall];
    weightValues = map[conuserWeight];
  }
}
