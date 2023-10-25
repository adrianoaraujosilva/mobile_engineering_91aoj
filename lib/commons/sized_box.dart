import 'package:flutter/material.dart';

class SizedBoxWidget extends StatelessWidget {
  const SizedBoxWidget({
    super.key,
    this.height,
    this.width,
    this.child,
  });

  final double? height;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height ?? 200, width: width, child: child);
  }
}
