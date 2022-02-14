//
//  ViewController.swift
//  Calculator
//
//  Created by 이해주 on 2022/02/14.
//

import UIKit

enum Operation {
    case Plus
    case Subtract
    case Multiply
    case Divide
    case unowned
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var outputLabel: UILabel!
    var displayNum = ""
    var prevNum = ""
    var result = ""
    var currentOperation: Operation = .unowned
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func operation(_ operation: Operation) {
        if self.currentOperation != .unowned  { // 조건: 이전에 전달받은 'operation' 값이 존재할 경우
            if !self.displayNum.isEmpty  { // 조건 : '=' 연산을 입력받았을 경우를 고려
                guard let firstNum = Double(self.prevNum) else { return }
                guard let secondNum = Double(self.displayNum) else { return }
                self.displayNum = "" // 초기화
                
                
                switch operation {
                case .Plus:
                    self.result = "\(firstNum + secondNum)"
                case .Subtract:
                    self.result = "\(firstNum - secondNum)"
                case .Multiply:
                    self.result = "\(firstNum * secondNum)"
                case .Divide:
                    self.result = "\(firstNum / secondNum)"
                default:
                    break
                }
                
                self.prevNum = result // 연속된 연산 계산을 고려하기 위해 prevNum 계산된 값을 추가.
                
                // 소수가 아닐 경우 정수로 변환하여 '.'을 가지고 있는 string을 foramt함.
                if let formatResult = Double(self.result), formatResult.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(formatResult))"
                }
                self.outputLabel.text = self.result
            }
            self.currentOperation = operation
            
        } else { // 조건: 이전에 전달 받은 'operation' 값이 존재하지 않을 경우
            self.currentOperation = operation
            self.prevNum = self.displayNum // 전달 받은 연산자와 계산할 값을 저장
            self.displayNum = "" // 초기화
        }
        
    }
    
    
    /* 숫자 패드 입력 값을 저장하고 화면에 보여주는 로직 */
    @IBAction func tapNumberpad(_ sender: UIButton) {
        guard let selectedNum = sender.title(for: .normal) else { return }
        if displayNum.count < 9 {
            self.displayNum += selectedNum
            self.outputLabel.text = self.displayNum
        }
    }
    
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        // 조건 : charater count 길이가 8 이하이고 "." 값을 이전에 포함하지 않았을 경우
        if self.displayNum.count < 8, !self.displayNum.contains(".") {
            displayNum += displayNum.isEmpty ? "0.0" : "." // 삼항연산자. dispalyNum일 경우에는 "0.0" 텍스트 자체를 입력
            self.outputLabel.text = self.displayNum
        }
    }
    
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
        operation(.Divide)
    }
    
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        operation(.Multiply)
    }
    
    
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        operation(.Subtract)
    }
    
    
    @IBAction func tapPlusButton(_ sender: UIButton) {
        operation(.Plus)
    }
    
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
        operation(self.currentOperation)
    }
    
    
    /* 모든 데이터 값 초기화 */
    @IBAction func tapResetButton(_ sender: UIButton) {
        self.outputLabel.text = "0"
        self.displayNum = ""
        self.result = ""
        self.prevNum = ""
        self.currentOperation = .unowned
    }
    
    
}

