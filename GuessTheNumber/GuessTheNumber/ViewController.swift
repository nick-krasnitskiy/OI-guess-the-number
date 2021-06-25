//
//  ViewController.swift
//  GuessTheNumber
//
//  Created by Nick Krasnitskiy on 22.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var sliderLabel: UISlider!
    
    var randomNumber: Int = 0
    var answer: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateState(action: nil)
    }
    
    func guessTheNumber() {
        randomNumber = Int.random(in: 0...100)
        print(randomNumber)
    }
    
    func updateState(action: UIAlertAction!) {
        sliderLabel.value = 50
        valueLabel.text = ""
        guessTheNumber()
    }
    
    func alertGeenrate(alertTitle: String, alertMessage: String, actionTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        valueLabel.text = String(format: "%.f", sender.value)
        answer = Int(round(sender.value))
    }
    
    @IBAction func checkAnswerTapped(_ sender: UIButton) {
        if answer < randomNumber {
            alertGeenrate(alertTitle: "Wrong", alertMessage: "Your answer \(answer) is less than the guessed number.", actionTitle: "Try again", handler: nil)
        } else if answer > randomNumber {
            alertGeenrate(alertTitle: "Wrong", alertMessage: "Your answer \(answer) is more than the guessed number.", actionTitle: "Try again", handler: nil)
        } else {
            alertGeenrate(alertTitle: "Right", alertMessage: "Your have guessed the number. Your answer \(answer) equals the guessed number. Сongratulations!", actionTitle: "OK", handler: updateState)
        }
    }
}

