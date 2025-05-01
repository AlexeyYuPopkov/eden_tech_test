import 'package:flutter/material.dart';

mixin ShowDialogHelper {
  ScaffoldFeatureController showSnackBar<T>({
    required BuildContext context,
    required String text,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: behavior,
        action: action,
      ),
    );
  }
}
