import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  RxString expression = ''.obs;
  RxString result = '0'.obs;

  final Parser parser = Parser();
  final ContextModel contextModel = ContextModel();

  void appendExpression(String value) {
    expression.value += value;
  }

  void evaluateExpression() {
    try {
      Expression exp = parser.parse(expression.value);
      result.value = exp.evaluate(EvaluationType.REAL, contextModel).toString();
    } catch (e) {
      result.value = 'Error';
    }
  }

  void clearExpression() {
    expression.value = '';
    result.value = '0';
  }
}
