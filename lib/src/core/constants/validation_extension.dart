import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This extension is for form validations using the [FormKey] approach
/// Import this file in any form view and call the methods from the [Buildcontext]'s
/// [context] variable
///
/// This extension still needs improvement
extension ValidationExtension on BuildContext {
  String? validateTextField(String? input) {
    if (input!.isEmpty) {
      return 'This field cannot be empty';
    } else {
      return null;
    }
  }
}
