import 'package:flutter/material.dart';

class TeXWidget extends StatefulWidget {
  final String math;

  const TeXWidget({super.key, required this.math});

  @override
  State<TeXWidget> createState() => _TeXWidgetState();
}

class _TeXWidgetState extends State<TeXWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
