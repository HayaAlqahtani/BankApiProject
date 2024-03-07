//
//  WithdrawViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Haya Alqahtani on 06/03/2024.
//

import UIKit
import Eureka

class WithdrawViewController: FormViewController {
    var usertoken: String?
    weak var delegate: UpdateDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        withdrawform()
    }
    func withdrawform(){
        form +++ Section("Add withdraw")
        <<< TextRow() {row in
            row.title = "Withdraw"
            row.placeholder = "ADD YOUR WITHDRAW AMOUNT"
            row.tag = "Withdraw"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        +++ Section("   ")
        <<< ButtonRow() { row in
            row.title = "add"
            row.onCellSelection { cell, row in
                print("button cell tapped")
                self.withdrawTapped()
            }
        }
    }
    @objc func withdrawTapped(){
        
        let errors = form.validate()
        guard errors.isEmpty else{
            presentAlertWithTitle(title: "error!!", message: "Some fields are empty")
            return
        }
        let withdrawRow : TextRow? = form.rowBy(tag: "Withdraw")
        let withdraw = withdrawRow?.value ?? ""
        
        guard let amount = Double(withdraw) else {
            presentAlertWithTitle(title: "Error", message: "Invalid withdraw amount")
            return
        }
        
        let amountChange = AmountChange(amount: amount)
        
        NetworkManager.shared.withdraw(token: usertoken ?? "" , amountChange: amountChange) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(_):
                    let profileVC = ProfileViewController()
                    self.navigationController?.pushViewController(profileVC, animated: true)
                    
                case .failure(let error):
                    print(error)
                    self.presentAlertWithTitle(title: "Error", message: "Failed to withdraw. Please try again.")
                }
            }
            
        }
    }
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
}

