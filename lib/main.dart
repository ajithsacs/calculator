import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitadds/CalculatorScreen.view.dart';

void main() {
  runApp(ScientificCalculatorApp());
}

class ScientificCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScientificCalculator(),
    );
  }
}
