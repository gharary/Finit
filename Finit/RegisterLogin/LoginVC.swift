//
//  LoginVC.swift
//  Finit
//
//  Created by Mohammad Gharari on 1/1/18.
//  Copyright © 2018 Mohammad Gharari. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
       
    }

    override func viewDidLayoutSubviews() {
        setupTouchKeyboard()
    }
    
    func setupTouchKeyboard() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        usernameTF.roundCorners([.topLeft, .topRight], radius: 5)
        passwordTF.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        
        loginButton.layer.cornerRadius = 3
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor(red: 0.0 / 255.0, green: 212.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0).cgColor

    }
    @objc func dismissKeyboard (){
        self.view.endEditing(true)
        
    }
    
    
    private func setupTextFields() {
        
        let font = UIFont(name: "IRANSANSMOBILE", size: 16)!
        
        
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font: font]
        usernameTF.attributedPlaceholder = NSAttributedString(string: "TestCode", attributes: attributes)
        
        passwordTF.attributedPlaceholder = NSAttributedString(string: "رمز عبور را وارد", attributes: attributes)
        
        
        
    }
    
    @IBAction func segueToSignup(_ sender: UIButton) {
        performSegue(withIdentifier: "showSignUpVC", sender: nil)
        
    }
    @IBAction func loginBtn(_ sender: UIButton) {
        
    }
    
    
}
