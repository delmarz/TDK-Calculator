//
//  ViewController.swift
//  Retro Calc
//
//  Created by Kryptonite on 2/17/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Equal = "="
        case Empty = "Empty"
    }

    
    @IBOutlet weak var outputLabel: UILabel!
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    var length: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("ricky", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        let tapLabel = UITapGestureRecognizer(target: self, action: Selector("labelTapped:"))
        outputLabel.userInteractionEnabled = true
        outputLabel.addGestureRecognizer(tapLabel)
        
    }
    
    func labelTapped(tapRecognizer: UITapGestureRecognizer) {
        print("tapped!")
        runningNumber = ""
        currentOperation = Operation.Empty
        outputLabel.text = runningNumber
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
        outputLabel.font = UIFont(name: "Minecraft", size: 39)
    }
    
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Substract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    // MARK:
    // MARK: Private Methods
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(op: Operation) {
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                }
                
                leftValString = result
                
                length = result.characters.count
                print("wow \(length)")
                var final:String
                
                if length >= 11 {
                    final = "Shiela: OK NOTED!"
                    outputLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
                    outputLabel.text = final;
                } else {
                    final = result
                    outputLabel.text = final
                }
      
                
                //outputLabel.text = result
            }
            currentOperation = op
            
        } else {
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    

}

