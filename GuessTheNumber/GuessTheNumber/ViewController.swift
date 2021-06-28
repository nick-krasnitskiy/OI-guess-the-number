//
//  ViewController.swift
//  GuessTheNumber
//
//  Created by Nick Krasnitskiy on 22.06.2021.
//

import UIKit

protocol ViewControllerDelegate {
    func update(savedFromBorder: String, savedToBorder: String)
}

class ViewController: UIViewController, ViewControllerDelegate {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var sliderLabel: UISlider!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var numberOfStepsLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var leftValueLabel: UILabel!
    @IBOutlet weak var rightValueLabel: UILabel!
    
    var randomNumber: Int = 0
    var answer: Int = 0
    var stepsNumber: Int = 0
    var leftRangeBorder: Int = 0
    var rightRangeBorder: Int = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateState(action: nil)
    }
    
    func guessTheNumber() {
        randomNumber = Int.random(in: leftRangeBorder...rightRangeBorder)
        print(randomNumber)
    }
    
    func updateState(action: UIAlertAction!) {
        stepsNumber = 0
        guessTheNumber()
        sliderLabel.value = Float((rightRangeBorder - leftRangeBorder)/2)
        valueLabel.text = ""
        numberOfStepsLabel.text = String(stepsNumber)
        leftValueLabel.text = String(leftRangeBorder)
        rightValueLabel.text = String(rightRangeBorder)
        sliderLabel.minimumValue = Float(leftRangeBorder)
        sliderLabel.maximumValue = Float(rightRangeBorder)
    }
    
    func alertGeenrate(alertTitle: String, alertMessage: String, actionTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
    
    func updateSteps(action: UIAlertAction!) {
        stepsNumber += 1
        numberOfStepsLabel.text = String(stepsNumber)
        
    }
    
    func updateUI() {
        mainLabel.text = NSLocalizedString("GUESS_THE_NUMBER", comment:"GUESS THE NUMBER!")
        answerLabel.text = NSLocalizedString("ANSWER", comment:"Your answer:")
        stepLabel.text = NSLocalizedString("STEP", comment:"Number of steps:")
        checkButton.setTitle(NSLocalizedString("CHECK", comment:"CHECK"), for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SecondViewController else { return }
                destination.delegate = self
    }
    
    func update(savedFromBorder: String, savedToBorder: String) {
        leftRangeBorder = Int(savedFromBorder) ?? 0
        rightRangeBorder = Int(savedToBorder) ?? 100
        updateState(action: nil)
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        valueLabel.text = String(format: "%.f", sender.value)
        answer = Int(round(sender.value))
    }
    
    @IBAction func checkAnswerTapped(_ sender: UIButton) {
        let alertTitleOne = NSLocalizedString("ALERT_TITLE_ONE", comment:"Wrong")
        let alertTitleTwo = NSLocalizedString("ALERT_TITLE_TWO", comment:"Right")
        
        let alertMessageOne = String(format: NSLocalizedString("ALERT_MESSAGE_ONE", comment: ""), "\(answer)")
        let alertMessageTwo = String(format: NSLocalizedString("ALERT_MESSAGE_TWO", comment: ""), "\(answer)")
        let alertMessageThree = String(format: NSLocalizedString("ALERT_MESSAGE_THREE", comment: ""), "\(answer)")
        
        let alertActionTitleOne = NSLocalizedString("ALERT_ACTION_TITLE_ONE", comment:"Try again")
        let alertActionTitleTwo = NSLocalizedString("ALERT_ACTION_TITLE_TWO", comment:"OK")
        
        if answer < randomNumber {
            alertGeenrate(alertTitle: alertTitleOne, alertMessage: alertMessageOne, actionTitle: alertActionTitleOne, handler: updateSteps)
        } else if answer > randomNumber {
            alertGeenrate(alertTitle: alertTitleOne, alertMessage: alertMessageTwo, actionTitle: alertActionTitleOne, handler: updateSteps)
        } else {
            alertGeenrate(alertTitle: alertTitleTwo, alertMessage: alertMessageThree, actionTitle: alertActionTitleTwo, handler: updateState)
            updateSteps(action: nil)
            
        }
        
    }
}



