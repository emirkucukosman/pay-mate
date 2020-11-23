//
//  AccountVC.swift
//  PayMate
//
//  Created by Emir Küçükosman on 24.11.2020.
//

import UIKit

class AccountVC: UIViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAccountBalance()
    }
    
    func fetchAccountBalance() {
        
        ApiService.shared.accountTask { (account, error) in
            
            if error != nil {
                let alert = self.getAlert(title: error!, message: nil, handler: nil)
                return DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
            
            if let account = account {
                DispatchQueue.main.async {
                    self.balanceLabel.text = "\(account.balance)$"
                }
            } else {
                let alert = self.getAlert(title: "Can not fetch balance", message: nil, handler: nil)
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
            
        }
    }
    
    @IBAction func logoutTapped() {
        UserDefaults.standard.removeObject(forKey: "token")
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let loginVC = storyboard.instantiateViewController(identifier: "LoginVC")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = loginVC
    }
}
