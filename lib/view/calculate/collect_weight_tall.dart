import 'package:flutter/material.dart';

class CollectWeightTall extends StatefulWidget {
  const CollectWeightTall({
    Key? key,
    this.hintText,
    this.lableText,
    this.save,
    this.onFieldSubmitted,
    this.onChanged,
    this.width,
  }) : super(key: key);
  final String? hintText;
  final String? lableText;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? save;
  final Function(String)? onChanged;
  final double? width;

  @override
  State<CollectWeightTall> createState() => _CollectWeightTallState();
}

class _CollectWeightTallState extends State<CollectWeightTall> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _key,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: size.width * 0.07,
          end: size.width * 0.07,
        ),
        child: SizedBox(
          width: widget.width,
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.lableText,
              hintStyle: const TextStyle(color: Colors.white),
              labelStyle: const TextStyle(color: Colors.white),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'please enter the Age value';
              } else {
                return null;
              }
            },
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            onSaved: widget.save,
          ),
        ),
      ),
    );
  }
}
