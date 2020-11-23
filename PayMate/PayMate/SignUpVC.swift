//
//  SingUpVC.swift
//  PayMate
//
//  Created by Emir Küçükosman on 10.11.2020.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()        
        stackView.setCustomSpacing(50, after: titleLabel)
        stackView.setCustomSpacing(30, after: passwordTxt)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func signUpTapped() {
        
        if usernameTxt.text != "" && emailTxt.text != "" && passwordTxt.text != "" {
            
            let credentials = Credentials(username: usernameTxt.text!, email: emailTxt.text!, password: passwordTxt.text!)
            
            ApiService.shared.authTask(with: credentials, taskType: .register) { (response, error) in
                
                if error != nil {
                    let alert = self.getAlert(title: error!, message: nil, handler: nil)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                if let response = response {
                    let alert = self.getAlert(title: response.message, message: nil) { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = self.getAlert(title: "Unexpected error has occured", message: nil, handler: nil)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            }
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            usernameTxt.resignFirstResponder()
            emailTxt.becomeFirstResponder()
        } else if textField.tag == 1 {
            emailTxt.resignFirstResponder()
            passwordTxt.becomeFirstResponder()
        } else {
            passwordTxt.resignFirstResponder()
        }
        return true
    }
    
}
