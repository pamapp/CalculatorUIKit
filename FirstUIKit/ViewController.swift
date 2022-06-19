//
//  ViewController.swift
//  FirstUIKit
//
//  Created by Alina Potapova on 17.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    
    var firstNumber: Double = 0
    var resultNumber: Double = 0
    var currentOperations: Operation?
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 100)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }
    
    private func setupNumberPad() {
        let FontSize: CGFloat = 35
        let buttonSize: CGFloat = view.frame.size.width / 4
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold, scale: .large)
       
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize * 2 - 10, height: buttonSize - 10))
        zeroButton.layer.cornerRadius = zeroButton.frame.width / 4
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.backgroundColor = .separator
        zeroButton.setTitle("0", for: .normal)
        zeroButton.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize)
        zeroButton.tag = 1
        holder.addSubview(zeroButton)
        zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        let commaButton = UIButton(frame: CGRect(x: buttonSize * 2, y: holder.frame.size.height - buttonSize, width: buttonSize - 10, height: buttonSize - 10))
        
        commaButton.layer.masksToBounds = true
        commaButton.layer.cornerRadius = commaButton.frame.width / 2
        commaButton.clipsToBounds = true
        
        commaButton.setTitleColor(.white, for: .normal)
        commaButton.backgroundColor = .separator
        commaButton.setTitle(",", for: .normal)
        commaButton.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize)
        commaButton.tag = 1
        holder.addSubview(commaButton)
//        commaButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        
        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 2), width: buttonSize - 10, height: buttonSize - 10))
            
            button1.layer.masksToBounds = true
            button1.layer.cornerRadius = button1.frame.width / 2
            button1.clipsToBounds = true
            
            button1.setTitleColor(.white, for: .normal)
            button1.backgroundColor = .separator
            button1.setTitle("\(x+1)", for: .normal)
            button1.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize)
            
            holder.addSubview(button1)
            button1.tag = x+2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 3), width: buttonSize - 10, height: buttonSize - 10))
           
            button2.layer.masksToBounds = true
            button2.layer.cornerRadius = button2.frame.width / 2
            button2.clipsToBounds = true
            
            button2.setTitleColor(.white, for: .normal)
            button2.backgroundColor = .separator
            button2.setTitle("\(x+4)", for: .normal)
            button2.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize)
            
            holder.addSubview(button2)
            button2.tag = x+5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 4), width: buttonSize - 10, height: buttonSize - 10))
            
            button3.layer.masksToBounds = true
            button3.layer.cornerRadius = button3.frame.width / 2
            button3.clipsToBounds = true
            
            button3.setTitleColor(.white, for: .normal)
            button3.backgroundColor = .separator
            button3.setTitle("\(x+7)", for: .normal)
            button3.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize)

            holder.addSubview(button3)
            button3.tag = x + 8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize - 10, height: buttonSize - 10))
        
        clearButton.layer.cornerRadius = clearButton.frame.width / 2
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .systemGray
        clearButton.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize)
        clearButton.setTitle("C", for: .normal)
        
        holder.addSubview(clearButton)
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        
        let signButton = UIButton(frame: CGRect(x: buttonSize, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize - 10, height: buttonSize - 10))
        
        signButton.layer.cornerRadius = signButton.frame.width / 2
        signButton.tintColor = .black
        signButton.backgroundColor = .systemGray
        signButton.setImage(UIImage(systemName: "plus.slash.minus", withConfiguration: sizeConfig), for: .normal)
        holder.addSubview(signButton)
        
        signButton.addTarget(self, action: #selector(changeSign), for: .touchUpInside)
        
        let percentButton = UIButton(frame: CGRect(x: buttonSize * 2, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize - 10, height: buttonSize - 10))
        
        percentButton.layer.cornerRadius = percentButton.frame.width / 2
        percentButton.tintColor = .black
        percentButton.backgroundColor = .systemGray
        percentButton.setImage(UIImage(systemName: "percent", withConfiguration: sizeConfig), for: .normal)
        holder.addSubview(percentButton)
//        percentButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        
        
        let operations = ["equal", "plus", "minus", "multiply", "divide"]
        
        for x in 0..<5 {
            let button_operand = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height - (buttonSize * CGFloat(x + 1)), width: buttonSize - 10, height: buttonSize - 10))
           
            button_operand.layer.masksToBounds = true
            button_operand.layer.cornerRadius = button_operand.frame.width / 2
            button_operand.clipsToBounds = true
            
            button_operand.setImage(UIImage(systemName: operations[x], withConfiguration: sizeConfig), for: .normal)
            
            button_operand.tintColor = .white
            button_operand.backgroundColor = .systemOrange
            button_operand.tag = x + 1
            button_operand.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize)
            holder.addSubview(button_operand)
            button_operand.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        }
        
        resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
        holder.addSubview(resultLabel)
      
    }
    
    @objc func clearResult() {
        resultLabel.text = "0"
        currentOperations = nil
        firstNumber = 0
    }
    
    @objc func changeSign() {
        if let text = resultLabel.text, let value = Double(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        firstNumber = firstNumber * (-1)
        
        resultLabel.text = "\(firstNumber)"
        currentOperations = nil
        firstNumber = 0
    }

    
    @objc func zeroTapped() {
        if resultLabel.text != "0" {
            if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        else if resultLabel.text == "-0.0" {
            resultLabel.text = "\(tag * -1)"
        }
        else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Double(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        if tag == 1 {
            if let operation = currentOperations {
                var secondNumber : Double = 0
                if let text = resultLabel.text, let value = Double(text) {
                    secondNumber = value
                }
                
                switch operation {
                case .add:
                    firstNumber = firstNumber + secondNumber
                    secondNumber = 0
                    if firstNumber.truncatingRemainder(dividingBy: 1) == 0 {
                        resultLabel.text = "\(Int(firstNumber))"
                    } else {
                        resultLabel.text = "\(Double(round(1000 * firstNumber) / 1000))"
                    }
                    currentOperations = nil
                    firstNumber = 0
                    
                    break
                    
                case .subtract:
                    firstNumber = firstNumber - secondNumber
                    secondNumber = 0
                    if firstNumber.truncatingRemainder(dividingBy: 1) == 0 {
                        resultLabel.text = "\(Int(firstNumber))"
                    } else {
                        resultLabel.text = "\(Double(round(1000 * firstNumber) / 1000))"
                    }
                    currentOperations = nil
                    firstNumber = 0
                    
                    break
                    
                case .multiply:
                    firstNumber = firstNumber * secondNumber
                    secondNumber = 0
                    if firstNumber.truncatingRemainder(dividingBy: 1) == 0 {
                        resultLabel.text = "\(Int(firstNumber))"
                    } else {
                        resultLabel.text = "\(Double(round(1000 * firstNumber) / 1000))"
                    }
                    currentOperations = nil
                    firstNumber = 0
                    
                    break
                    
                case .divide:
                    if secondNumber == 0 {
                        resultLabel.text = "Error"
                    } else {
                        firstNumber = firstNumber / secondNumber
                        if firstNumber.truncatingRemainder(dividingBy: 1) == 0 {
                            resultLabel.text = "\(Int(firstNumber))"
                        } else {
                            resultLabel.text = "\(Double(round(1000 * firstNumber) / 1000))"
                        }
                    }
                    secondNumber = 0
                    currentOperations = nil
                    firstNumber = 0
                    break
                }
            
            }
        }
        else if tag == 2 {
            currentOperations = .add
        }
        else if tag == 3 {
            currentOperations = .subtract
        }
        else if tag == 4 {
            currentOperations = .multiply
        }
        else if tag == 5 {
            currentOperations = .divide
        }
        
    }
    
}
