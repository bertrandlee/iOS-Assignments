//
//  ViewController.swift
//  iOS-Lesson12-Calculator
//
//  Created by Bertrand Lee on 20/4/16.
//  Copyright © 2016 Bertrand Lee. All rights reserved.
//

import UIKit

// This implements a calculator app using the MVC (Model-View-Controller) model

enum MathOperation
{
    case None, Add, Subtract, Multiply, Divide
}

enum CommandType
{
    case None, Digit, Operator
}

// Accumulator class
class Accumulator
{
    private var m_accValue:Float = 0
    private var m_currOperation:MathOperation = MathOperation.None
    
    // Resets accumulator value and curr operation
    func resetAll()
    {
        m_accValue = 0
        m_currOperation = MathOperation.None
    }
    
    // Gets accumulator value
    func getValue() -> Float
    {
        return m_accValue
    }
    
    // Sets current accumulator operation
    func setOperation(operation:MathOperation)
    {
        m_currOperation = operation
    }

    // Updates accumulator value based on input and current operation
    func updateValue(input:Int)
    {
        let floatInput:Float = Float(input)
        
        switch m_currOperation
        {
        case MathOperation.None:
            m_accValue = floatInput
            
        case MathOperation.Add:
            m_accValue += floatInput
            
        case MathOperation.Subtract:
            m_accValue -= floatInput
            
        case MathOperation.Multiply:
            m_accValue *= floatInput
            
        case MathOperation.Divide:
            m_accValue /= floatInput
            
        default:
            print("No current math operator, ignoring...")
        }
    }
    
}

// Calculator class (Model in MVC design pattern)
class Calculator
{

    private var m_entryValue:Int = 0
    private var m_displayValue:Float = 0
    private var m_lastCommand:CommandType = CommandType.None
    private var m_accumulator:Accumulator = Accumulator()
    private var m_computeLastCalled:Bool = false
    
    // This returns the display value
    func getDisplayValue() -> String
    {
        let intDisplayValue:Int = Int(m_displayValue)
        
        // If float value has no decimal places (eg. 5.0), display integer
        if (m_displayValue == Float(intDisplayValue))
        {
            return String(intDisplayValue)
        }
        else
        {
            return String(m_displayValue)
        }
    }
    
    // This resets the entry value
    func resetEntryValue()
    {
        m_entryValue = 0
    }
    
    // This resets everything
    func resetAll()
    {
        m_entryValue = 0
        m_displayValue = 0
        m_accumulator.resetAll()
        m_lastCommand = CommandType.None
        m_computeLastCalled = false
    }
    
    // Appends new integer button press to current output
    // Handles special case where existing value is 0 (replace output)
    func appendDigit(input:Int)
    {
        if (m_entryValue == 0)
        {
            // In the case current value is 0, replace value
            m_entryValue = Int(input)
        }
        else
        {
            // In the case current value is not 0, append to value
            m_entryValue = Int(String(m_entryValue) + String(input))!
        }
        
        m_displayValue = Float(m_entryValue)
    }
    
    // Operator button command handler
    func processOperatorCommand(operation:MathOperation)
    {
        // Update the accumulated value based the existing operator, if any (skip this if compute was already called)
        if (!m_computeLastCalled)
        {
            m_accumulator.updateValue(Int(m_entryValue))
        }
        m_displayValue = m_accumulator.getValue()
        
        // Update the current operator to the new value
        m_accumulator.setOperation(operation)
        
        
        m_computeLastCalled = false;
    }
    
    // Equals button command handler
    func processComputeCommand()
    {
        // TODO: Bug here with performing math operations after compute
        m_accumulator.updateValue(Int(m_entryValue))
        m_accumulator.setOperation((MathOperation.None))
        m_displayValue = m_accumulator.getValue()
        m_computeLastCalled = true
    }
    
}

class ViewController: UIViewController
{
    var m_calc:Calculator = Calculator()

    // View
    @IBOutlet weak var displayLabel: UILabel!
    
    func updateDisplay()
    {
        displayLabel.text = m_calc.getDisplayValue()
    }
    
    
    // Controllers
    
    // Digit button was clicked
    @IBAction func onNumberButtonClicked(sender: AnyObject)
    {
        let button:UIButton = sender as! UIButton
        let number:Int = Int((button.titleLabel?.text!)!)!
       
        m_calc.appendDigit((number))
        updateDisplay()
    }
    
    // Operator button was clicked
    @IBAction func onOperatorButtonClicked(sender: AnyObject)
    {
        let button:UIButton = sender as! UIButton
        let operation:String = (button.titleLabel?.text!)!
        
        switch (operation)
        {
            case "+":
                m_calc.processOperatorCommand(MathOperation.Add)
            
            case "-":
                m_calc.processOperatorCommand(MathOperation.Subtract)
            
            case "x":
                m_calc.processOperatorCommand(MathOperation.Multiply)
            
            case "÷":
                m_calc.processOperatorCommand(MathOperation.Divide)
            
            default:
                // Process unexpected error condition
                print("ERROR: Unexpected operator encountered")
        }
        
        // Reset entry value so next number can be entered
        m_calc.resetEntryValue()
    }
    
    // Equals button was clicked
    @IBAction func onEqualsButtonClicked(sender: AnyObject)
    {
        m_calc.processComputeCommand()
        updateDisplay()
    }
    
    // AC button was clicked
    @IBAction func onACButtonClicked(sender: AnyObject)
    {
        m_calc.resetAll()
        updateDisplay()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayLabel.layer.borderColor = UIColor.greenColor().CGColor;
        displayLabel.layer.borderWidth = 3.0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

