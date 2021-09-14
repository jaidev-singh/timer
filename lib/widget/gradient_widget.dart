import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final Widget widget;
  const GradientWidget({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.red, Colors.yellow, Colors.blue, Colors.purple],
        ),
      ),
      child: widget,
    );
  }
}
