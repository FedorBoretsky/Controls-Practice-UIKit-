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
    
    var modelNumber = 24 {
        didSet {
            modelNumber %= 256  // Values is in range 0...255
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
    
    /// Show actual value of modelNumber on all controls.
    func updateUI() {
        button.setTitle("\(modelNumber)", for: [])
        textField.text = "\(modelNumber)"
        slider.value = Float(modelNumber)
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
            switchResult += singleSwitch.tag * (singleSwitch.isOn ? 1 : 0)
        }
        modelNumber = switchResult
    }
    
}

