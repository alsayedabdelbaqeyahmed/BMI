import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  final VoidCallback? press;
  const CalculateButton({Key? key, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: EdgeInsetsDirectional.only(
          top: size.height * 0.02,
        ),
        width: size.width * 0.7,
        height: size.height * 0.1,
        child: IconButton(
          onPressed: press,
          icon: Image.asset(
            'assets/images/calculate_btn.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
