import 'package:flutter_calculator/util/index.dart';

enum Operator { plus, minus, multiply, divide, unknown }

class CalculatorController extends GetxController {
  /* 계산 로직에 필요한 변수 */
  String displayNum = "0"; // 화면에 보여지는 숫자 변수 (0 을 초기값으로 가짐)
  String computeNum = "0"; // 입력된 값을 저장하는 변수
  Operator currentOperator = Operator.unknown;
  late String? prevNum;

  /* Intent */

  // 숫자 키패드를 터치 했을 때
  void tapNumberKeypad(String number) {
    if (computeNum.length < 9) {
      // 이전에 입력된 값이 없다면 전달 받은 숫자 인자값을 입력, 반대의 경우 String 숫자를 더함
      computeNum = computeNum == "0" ? number : computeNum + number;
      displayNum = computeNum;
    }
    update();
  }

  // 'AC' 리셋 로직
  void reset() {
    displayNum = "0";
    computeNum = "0";
    currentOperator = Operator.unknown;
    prevNum = null;
    update();
  }

  // '.' 소수점을 추가 로직
  void tapDotKeypad() {
    if (computeNum.length < 8) {
      computeNum = computeNum == "0" ? "0." : computeNum + "."; // 초기값 상태를 고려
      displayNum = computeNum;
    }
    update();
  }

  // 연산 로직
  void operate(Operator operation) {
    // 조건: 이전에 전달 받은 연산자가 있을 경우(계산을 진행)
    if (currentOperator != Operator.unknown) {
      if (computeNum != "0") {
        // '='을 입력했을 경우를 고려
        late double result;
        double firstNum = double.parse(prevNum!);
        double secondNum = double.parse(computeNum);

        computeNum = "0"; // 다음 계산을 위해 초기화

        // 연산 진행
        switch (operation) {
          case Operator.plus:
            result = firstNum + secondNum;
            break;
          case Operator.minus:
            result = firstNum - secondNum;
            break;
          case Operator.multiply:
            result = firstNum * secondNum;
            break;
          case Operator.divide:
            result = firstNum / secondNum;
        }
        prevNum = result.toString();

        // 실수 포맷팅
        if (result / 1 != 0) {
          // 실수가 아니라면 정수로 형 변환.
          displayNum = "${result.toInt()}";
        } else {
          displayNum = result.toString();
        }
      }
      currentOperator = operation;
    } else {
      currentOperator = operation;
      prevNum = computeNum; // 이전에 입력된 값을 저장
      computeNum = "0"; // 숫자값을 입력 받기 위해 초기화
    }
    update();
  }

  // 입력받은 연산자를 판별하는 로직
  void checkOperation(String operation) {
    switch (operation) {
      case "+":
        operate(Operator.plus);
        break;
      case "-":
        operate(Operator.minus);
        break;
      case "X":
        operate(Operator.multiply);
        break;
      case "%":
        operate(Operator.divide);
        break;
      default:
        operate(currentOperator); // '='는 입력했을 경우를 고려
    }
  }

  // 터치한 키패드 버튼의 종류를 확인하고 필요한 로직을 실행
  void checkKeypadType(String content) {
    if (numberKeypadContents.contains(content)) {
      tapNumberKeypad(content);
    } else if (operatorKeypadContents.contains(content)) {
      checkOperation(content);
    } else if (content == ".") {
      tapDotKeypad();
    } else {
      reset();
    }
  }
}
