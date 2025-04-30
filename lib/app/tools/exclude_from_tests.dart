import 'dart:io';

import 'package:flutter/material.dart';

final kIsTest = Platform.environment.containsKey('FLUTTER_TEST');

final class ExcludeFromTests extends StatelessWidget {
  final Widget child;
  final Widget? placeholder;

  const ExcludeFromTests({
    super.key,
    required this.child,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return kIsTest ? placeholder ?? const SizedBox() : child;
  }
}

final class WrapIfNotTests extends StatelessWidget {
  final Widget Function(BuildContext context, Widget child) wrapper;
  final Widget child;

  const WrapIfNotTests({
    super.key,
    required this.wrapper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return !kIsTest ? wrapper(context, child) : child;
  }
}
