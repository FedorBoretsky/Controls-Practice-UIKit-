//
//  ViewController.swift
//  Controls Practice (UIKit)
//
//  Created by Fedor Boretskiy on 02.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet var switches: [UISwitch]!
    
    let maxValue = 256
    
    var modelNumber = 24 {
        didSet {
            modelNumber = (modelNumber + maxValue) % maxValue  // Values is in range 0...255
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateSwitches()
        updateUI()
    }
    
    func rotateSwitches() {
        for `switch` in switches {
            `switch`.layer.transform = CATransform3DMakeRotation(-.pi/2, 0, 0, 1)
        }
    }
    
    // MARK: - Update interface
    
    /// Show actual value of modelNumber on all controls.
    func updateUI() {
        button.setTitle("\(modelNumber)", for: [])
        textField.text = "\(modelNumber)"
        slider.value = Float(modelNumber)
        updateSwitches()
    }
    
    /// Show actual value of modelNumber on switches
    func updateSwitches() {
        for `switch` in switches {
            `switch`.isOn = (`switch`.tag & modelNumber) > 0
        }
    }
    
    // MARK: - React to control's activity.
    
    @IBAction func buttonPressed() {
        modelNumber += 1
    }
    
    @IBAction func textFieldChanged() {
        var currentText = textField.text ?? ""
        currentText = currentText.replacingOccurrences(
            of: "\\D",
            with: "",
            options: .regularExpression,
            range: .none)
        modelNumber = Int(currentText) ?? 0
    }
    
    @IBAction func sliderChanged() {
        modelNumber = Int(slider.value)
    }
    
    @IBAction func switched() {
        var switchResult = 0
        for singleSwitch in switches {
            switchResult += singleSwitch.isOn ? singleSwitch.tag : 0
        }
        modelNumber = switchResult
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {        
        let tapPoint = sender.location(in: view)
        modelNumber += (tapPoint.x < view.bounds.midX) ? -1 : +1
    }
    
}

