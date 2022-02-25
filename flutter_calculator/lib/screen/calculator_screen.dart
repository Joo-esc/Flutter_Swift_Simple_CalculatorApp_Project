import 'package:flutter/material.dart';
import 'package:flutter_calculator/util/index.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(CalculatorController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<CalculatorController>(
              init: c,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /* 입력 & 계산 결과를 보여주는 텍스트 */
                    Container(
                      height: 150,
                      alignment: Alignment.centerRight,
                      child: Text(
                        c.displayNum,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    /* 키패드 그리드 뷰 */
                    StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 5,
                      children: [
                        keypadItem(Keypad(3, 1, "AC", kLightGrey)),
                        keypadItem(Keypad(1, 1, "%", kOrange)),
                        keypadItem(Keypad(1, 1, "7", kDarkGrey)),
                        keypadItem(Keypad(1, 1, "8", kDarkGrey)),
                        keypadItem(Keypad(1, 1, "9", kDarkGrey)),
                        keypadItem(Keypad(1, 1, "X", kOrange)),
                        keypadItem(Keypad(1, 1, "4", kDarkGrey)),
                        keypadItem(Keypad(1, 1, "5", kDarkGrey)),
                        keypadItem(Keypad(1, 1, "6", kDarkGrey)),
                        keypadItem(Keypad(1, 1, "-", kOrange)),
                        keypadItem(Keypad(1, 1, "1", kDarkGrey)),
                        keypadItem(Keypad(1, 1, "2", kDarkGrey)),
                        keypadItem(Keypad(1, 1, "3", kDarkGrey)),
                        keypadItem(Keypad(1, 1, "+", kOrange)),
                        keypadItem(Keypad(2, 1, "0", kLightGrey)),
                        keypadItem(Keypad(1, 1, ".", kLightGrey)),
                        keypadItem(Keypad(1, 1, "=", kOrange)),
                      ],
                    ),
                    SizedBox(),
                  ],
                );
              }),
        ),
      ),
    );
  }

  StaggeredGridTile keypadItem(Keypad keypad) {
    final c = Get.put(CalculatorController());
    return StaggeredGridTile.count(
      crossAxisCellCount: keypad.crossAxisCount,
      mainAxisCellCount: keypad.mainAxisCount,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(keypad.color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
        ),
        onPressed: () {
          c.checkKeypadType(keypad.content);
        },
        child: Text(
          keypad.content,
          style: const TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
