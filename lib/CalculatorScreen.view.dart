import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'adsController.dart';
import 'CalculatorController.dart';

class ScientificCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScientificCalculator(),
    );
  }
}

class ScientificCalculator extends StatelessWidget {
  // Use lazy loading to prevent memory overflow
  ScientificCalculator() {
    Get.lazyPut<AdController>(() => AdController());
    Get.lazyPut<CalculatorController>(() => CalculatorController());
  }

  @override
  Widget build(BuildContext context) {
    final AdController adController = Get.find();
    final CalculatorController calculatorController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _buildDisplay(calculatorController),
          const Divider(),
          _buildButtons(calculatorController),
          _buildAdButton(adController),
        ],
      ),
    );
  }

  Widget _buildDisplay(CalculatorController calculatorController) {
    return Container(
      height: 200, // Fixed height for the display area
      color: Colors.deepPurpleAccent,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Obx(() => Text(
                calculatorController.expression.value,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              )),
          const SizedBox(height: 10),
          Obx(() => Text(
                calculatorController.result.value,
                style: const TextStyle(fontSize: 48, color: Colors.white),
              )),
        ],
      ),
    );
  }

  Widget _buildButtons(CalculatorController calculatorController) {
    return Container(
      height: 400, // Fixed height for buttons
      color: Colors.grey[900],
      child: GridView.count(
        crossAxisCount: 4,
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          _buildButton('7', Colors.blue, calculatorController),
          _buildButton('8', Colors.blue, calculatorController),
          _buildButton('9', Colors.blue, calculatorController),
          _buildButton('/', Colors.orange, calculatorController),
          _buildButton('4', Colors.blue, calculatorController),
          _buildButton('5', Colors.blue, calculatorController),
          _buildButton('6', Colors.blue, calculatorController),
          _buildButton('*', Colors.orange, calculatorController),
          _buildButton('1', Colors.blue, calculatorController),
          _buildButton('2', Colors.blue, calculatorController),
          _buildButton('3', Colors.blue, calculatorController),
          _buildButton('-', Colors.orange, calculatorController),
          _buildButton('0', Colors.blue, calculatorController),
          _buildButton('.', Colors.blue, calculatorController),
          _buildButton('=', Colors.green, calculatorController,
              onPressed: calculatorController.evaluateExpression),
          _buildButton('+', Colors.orange, calculatorController),
          _buildButton('sin', Colors.purple, calculatorController),
          _buildButton('cos', Colors.purple, calculatorController),
          _buildButton('tan', Colors.purple, calculatorController),
          _buildButton('C', Colors.red, calculatorController,
              onPressed: calculatorController.clearExpression),
        ],
      ),
    );
  }

  Widget _buildAdButton(AdController adController) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder(
            init: AdController(),
            builder: (value) {
              return ElevatedButton(
                onPressed: () {
                  adController.showRewardedVideoAd();

                  // Get.snackbar("Ad Status", "Ad is not ready yet!");
                },
                child: const Text('View Rewarded Ad'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
              );
            }));
  }

  Widget _buildButton(
      String label, Color color, CalculatorController calculatorController,
      {Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed:
            onPressed ?? () => calculatorController.appendExpression(label),
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Text(label,
            style: const TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
}
