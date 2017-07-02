//
//  ViewController.swift
//  Reflex
//
//  Created by Jason Scott on 6/29/17.
//  Copyright © 2017 Jason Scott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    ///Outlets for Storyboard
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var currentNumberLabel : UILabel!
    ///Outlets for buttons
    @IBOutlet var button1 : UIButton!
    @IBOutlet var button2 : UIButton!
    @IBOutlet var button3 : UIButton!
    @IBOutlet var button4 : UIButton!
    @IBOutlet var button5 : UIButton!
    @IBOutlet var button6 : UIButton!
    @IBOutlet var button7 : UIButton!
    @IBOutlet var button8 : UIButton!
    @IBOutlet var button9 : UIButton!
    @IBOutlet var goButton : UIButton!
    
    
    ///Global Variables
    var currentNumber = 0
    var randomNumberArray = [Int]()
    var score = 0
    var timer = Timer()
    var seconds = 60
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomNumber()
        randomNumberArrayGenerator()
        changeButtonLabels()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///Function to change current number
    func randomNumber(){
        currentNumber = 1 + Int(arc4random_uniform(9))
        currentNumberLabel.text = String(currentNumber)
    }
    
    ///Function to change labels on Buttons
    func changeButtonLabels(){
        var buttonArray = [button1, button2, button3, button4, button5, button6, button7, button8, button9]
        for i in 0...buttonArray.count-1 {
            buttonArray[i]?.setTitle(String(randomNumberArray[i]), for: UIControlState.normal)
        }
    }
    
    ///Function to make an array of random numbers that aren't repeated
    func randomNumberArrayGenerator(){
        randomNumberArray = []
        randomNumberArray.append(1 + Int(arc4random_uniform(9)))
        while randomNumberArray.count < 9 {
            let newNumber = 1 + Int(arc4random_uniform(9))
            for _ in 0...randomNumberArray.count {
                if randomNumberArray.contains(newNumber){
                    ///do nothing
                }else{
                    randomNumberArray.append(newNumber)
                }}
        }
    }
    
    ///Actions for Buttons
    @IBAction func buttonPressed(_ button: UIButton) {
        if isTimerRunning == true {
            let buttonText = button.titleLabel?.text
            let currentText = currentNumberLabel.text
            if buttonText == currentText {
                score = score + 1
                
            } else if buttonText != currentNumberLabel.text {
                seconds = seconds - 1
                timerLabel.text = "\(seconds)"
            }
            scoreLabel.text = String(score)
            randomNumber()
            randomNumberArrayGenerator()
            changeButtonLabels()
            
        }
    }
    
    @IBAction func goButtonPressed(){
        if isTimerRunning == false{
            runTimer()
        }
        
    }
    
    ///Timer Functions
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    func updateTimer(){
        if seconds > 0 {
            seconds = seconds-1
            timerLabel.text = "\(seconds)"
        } else if seconds == 0{
            timer.invalidate()
        }
    }
}

