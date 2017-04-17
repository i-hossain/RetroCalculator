//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Ismail Hossain on 2017-04-12.
//  Copyright © 2017 Ismail Hossain. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        //playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func dividePressed(sender: UIButton) {
        processOperation(operation: .Divide, equalPressed: false)
        
    }
    
    @IBAction func multiplyPressed(sender: UIButton) {
        processOperation(operation: .Multiply, equalPressed: false)
        
    }
    
    @IBAction func addPressed(sender: UIButton) {
        processOperation(operation: .Add, equalPressed: false)
        
    }
    
    @IBAction func subtractPressed(sender: UIButton) {
        processOperation(operation: .Subtract, equalPressed: false)
        
    }
    
    @IBAction func equalPressed(sender: UIButton) {
        processOperation(operation: currentOperation, equalPressed: true)
        
    }
    
    @IBAction func clearPressed(sender: UIButton){
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
        
        outputLbl.text = "0"
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation, equalPressed: Bool) {
//        playSound()
        if currentOperation != Operation.Empty {
            //User selected an operator but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = leftValStr
            }
            if equalPressed {
                currentOperation = Operation.Empty
            } else {
                currentOperation = operation
            }
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }

}

