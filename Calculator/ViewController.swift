//
//  ViewController.swift
//  Calculator
//
//  Created by Zeyu Ding on 29/1/15.
//  Copyright (c) 2015 Zeyu Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var displayHistory: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            if digit != "." || display.text!.rangeOfString(".") == nil {
                display.text = display.text! + digit
            }
        } else {
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            appendHistory("\(operation)") // update the history display
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
            appendHistory("\(result)") // update the history display
        } else {
            displayValue = 0
        }
    }
    
    private func appendHistory(op: String) {
        if displayHistory.text == nil || displayHistory.text!.isEmpty {
            displayHistory.text = op
        } else {
            displayHistory.text = displayHistory.text! + ", \(op)"
        }
    }
    
    // reset the calculator
    @IBAction func clear() {
        displayHistory.text = nil
        displayValue = 0
        brain.clear()
        userIsInTheMiddleOfTypingANumber = false
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }

}

