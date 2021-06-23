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
        sliderLabel.value = 50
    }

    func guessTheNumber() -> Int {
        randomNumber = Int.random(in: 0...100)
        return randomNumber
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        valueLabel.text = String(format: "%.f", sender.value)
    }
    
    @IBAction func checkAnswerTapped(_ sender: UIButton) {
    }
    
    
}

