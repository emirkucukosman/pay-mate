//
//  ViewController.swift
//  PayMate
//
//  Created by Emir Küçükosman on 10.11.2020.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var backdrop: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.setCustomSpacing(50, after: titleLabel)
        stackView.setCustomSpacing(30, after: passwordTxt)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func signInTapped() {
        
        if usernameTxt.text != "" && passwordTxt.text != "" {
            
            backdrop.isHidden = false
            
            let credentials = Credentials(username: usernameTxt.text!, email: nil, password: passwordTxt.text!)
            
            ApiService.shared.authTask(with: credentials, taskType: .login) { (response, error) in
                
                if error != nil {
                    let alert = self.getAlert(title: error!, message: nil, handler: nil)
                    return DispatchQueue.main.async {
                        self.present(alert, animated: true) {
                            self.backdrop.isHidden = true
                        }
                    }
                }
                
                if let response = response {
                    UserDefaults.standard.setValue(response.token, forKey: "token")
                    self.performSegue(withIdentifier: "toAccountVC", sender: nil)
                } else {
                    let alert = self.getAlert(title: "Unexpected error has occured", message: nil, handler: nil)
                    return DispatchQueue.main.async {
                        self.present(alert, animated: true) {
                            self.backdrop.isHidden = true
                        }
                    }
                }
                
            }
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            usernameTxt.resignFirstResponder()
            passwordTxt.becomeFirstResponder()
        } else {
            passwordTxt.resignFirstResponder()
        }
        return true
    }

}

