import 'package:flutter/material.dart';

class ChoseTypeButton extends StatefulWidget {
  final BoxConstraints? constraints;
  const ChoseTypeButton({Key? key, this.constraints})
      : super(
          key: key,
        );

  @override
  _ChoseTypeButtonState createState() => _ChoseTypeButtonState();
}

class _ChoseTypeButtonState extends State<ChoseTypeButton> {
  String type = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        choseTypeButton(
          size: size,
          name: 'male',
          assets: 'assets/images/Male icon.png',
        ),
        choseTypeButton(
          size: size,
          name: 'female',
          assets: 'assets/images/Femaleicon.png',
        ),
      ],
    );
  }

  Widget choseTypeButton({
    @required Size? size,
    @required String? name,
    @required String? assets,
  }) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            type = name!;
          });
        },
        child: Container(
          width: size!.width * 0.25,
          height: size.height * 0.12,
          decoration: BoxDecoration(
            color: type.trim() == name!.trim()
                ? const Color(0xff72909D)
                : const Color(0xff2F3F4B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                assets!,
                color: type.trim() == name.trim() ? Colors.white : Colors.blue,
              ),
              Text(
                name,
                style: TextStyle(
                    color:
                        type.trim() == name.trim() ? Colors.white : Colors.blue,
                    fontSize: widget.constraints!.maxWidth * 0.05),
              )
            ],
          ),
        ),
      ),
    );
  }
}
