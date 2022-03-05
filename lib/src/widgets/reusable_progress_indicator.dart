import 'package:flutter/material.dart';

class ReusableProgressIndicator extends StatelessWidget {
  final Color? color;
  const ReusableProgressIndicator({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      width: 16,
      child: CircularProgressIndicator(
        color: color ?? Colors.white,
        strokeWidth: 3.0,
      ),
    );
  }
}
