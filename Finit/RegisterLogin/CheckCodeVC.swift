//
//  CheckCodeVC.swift
//  Finit
//
//  Created by Mohammad Gharari on 1/1/18.
//  Copyright © 2018 Mohammad Gharari. All rights reserved.
//

import UIKit

class CheckCodeVC: UIViewController , UITextFieldDelegate {
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var fourthTF: UITextField!
    @IBOutlet weak var mobileLbl: UILabel!
    
    
    @IBOutlet weak var checkCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        // Do any additional setup after loading the view.
        firstTF.becomeFirstResponder()
        
    }
    
    override func viewDidLayoutSubviews() {
        setupTouchKeyboard()
    }
    

    @IBAction func loginBtn(_ sender: UIButton) {
        //self.performSegueToReturnBack()
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func forgotPassBtn(_ sender: UIButton) {
        
    }
    @IBAction func checkCodeBtn(_ sender: UIButton) {
        
    }
    
    func setupTextFields() {
        firstTF.text = ""
        firstTF.delegate = self
        firstTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        secondTF.text = ""
        secondTF.delegate = self
        secondTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        thirdTF.text = ""
        thirdTF.delegate = self
        thirdTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        fourthTF.text = ""
        fourthTF.delegate = self
        fourthTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        if text?.utf16.count == 1 {
            switch textField {
            case firstTF:
                secondTF.becomeFirstResponder()
            case secondTF:
                thirdTF.becomeFirstResponder()
            case thirdTF:
                fourthTF.becomeFirstResponder()
            case fourthTF:
                callServer()
            default:
                break
            }
        } else {
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func callServer() {
        dismissKeyboard()
        print("Calling Server")
    }
    
    func setupTouchKeyboard() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        //checkCodeButton.layer.cornerRadius = 3
        //checkCodeButton.layer.borderWidth = 2
        //checkCodeButton.layer.borderColor = UIColor(red: 0.0 / 255.0, green: 212.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0).cgColor
        
    }
    @objc func dismissKeyboard (){
        self.view.endEditing(true)
        
    }
    
    
    
}
extension UIViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
