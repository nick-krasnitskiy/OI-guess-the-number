//
//  SecondViewController.swift
//  GuessTheNumber
//
//  Created by Nick Krasnitskiy on 26.06.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    var delegate: ViewControllerDelegate?

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var addButtonLabel: UIButton!
    
    
    override func viewDidLoad() {
        updateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addRangePressed(_ sender: UIButton) {
        guard let fromBorder = fromTextField.text, let toBorder = toTextField.text else {return}
        guard let savedFromBorder = saveSettings(fromBorder: fromBorder, toBorder: toBorder).0 else {return}
        guard let savedToBorder = saveSettings(fromBorder: fromBorder, toBorder: toBorder).1 else {return}
        delegate?.update(savedFromBorder: savedFromBorder, savedToBorder: savedToBorder)
    }
    
    func updateUI() {
        mainLabel.text = NSLocalizedString("SC_LABEL", comment:"Range of random number generation")
        fromTextField.placeholder = NSLocalizedString("SC_PH_ONE", comment:"From")
        toTextField.placeholder = NSLocalizedString("SC_PH_TWO", comment:"To")
        addButtonLabel.setTitle(NSLocalizedString("SC_ADD_BUTTON", comment:"ADD"), for: .normal)
    }
    
    func saveSettings(fromBorder: String, toBorder: String) -> (String?, String?) {
        let defaults = UserDefaults.standard
        defaults.setValue(fromBorder, forKey: "left range border")
        defaults.setValue(toBorder, forKey: "right range border")
        
        let savedSettings = (defaults.string(forKey: "left range border"),defaults.string(forKey: "right range border"))
        return savedSettings
    }
}
