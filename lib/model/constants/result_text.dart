import 'package:flutter/material.dart';

Text resultText({String? result, BoxConstraints? constr}) {
  return Text(
    result!,
    style: TextStyle(
      fontSize: constr!.maxWidth > 600
          ? constr.widthConstraints().maxWidth * 0.06
          : constr.widthConstraints().maxWidth * 0.08,
      color: double.parse(result) < 18.5
          ? Colors.blue
          : double.parse(result) < 25.0
              ? Colors.green
              : Colors.red,
    ),
  );
}
