import 'package:flutter/material.dart';
import 'package:weight_tracker_app/src/widgets/reusable_progress_indicator.dart';

class ReusableButton extends StatelessWidget {
  final bool isLoading;
  final void Function() onPressed;
  final Widget child;

  const ReusableButton(
      {Key? key,
      this.isLoading = false,
      required this.onPressed,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        side: BorderSide.none,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: isLoading
          ? const ReusableProgressIndicator()
          : FittedBox(child: child),
    );
  }
}
