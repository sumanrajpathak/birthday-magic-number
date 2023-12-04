import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final String? text;

  const NeumorphicContainer({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          border: Border.all(
            width: 0, //borderWidth
            color: Colors.grey.shade300, //borderColor
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(2, 2),
                blurRadius: 15,
                spreadRadius: 1),
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-2, -2),
                blurRadius: 15,
                spreadRadius: 1),
          ]),
      child: text != null
          ? Center(
              child: Text(
                text!,
                style: const TextStyle(fontSize: 24),
              ),
            )
          : const SizedBox.shrink(), //child widget of our button
    );
  }
}
