//
//  SecondViewController.swift
//  GuessTheNumber
//
//  Created by Nick Krasnitskiy on 26.06.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    var delegate: ViewControllerDelegate?
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addRangePressed(_ sender: UIButton) {
        guard let fromBorder = fromTextField.text, let toBorder = toTextField.text else {return}
        delegate?.update(fromBorder: fromBorder, toBorder: toBorder)
    }
}
