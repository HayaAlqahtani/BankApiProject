//
//  DepositViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Haya Alqahtani on 06/03/2024.
//

import UIKit
import SnapKit
import Eureka

class DepositViewController: FormViewController {
    
    var usertoken: String?
    
    weak var delegate: UpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        depositform()
        view.backgroundColor = .white
        
    }
    
    func depositform(){
        form +++ Section("Add deposit")
        <<< TextRow() {row in
            row.title = "DEPOSIT"
            row.placeholder = "ADD YOUR DEPOSIT AMOUNT"
            row.tag = "Deposit"
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
                self.depositTapped()
            }
        }
    }
    @objc func depositTapped(){
        
        let errors = form.validate()
        guard errors.isEmpty else{
            presentAlertWithTitle(title: "error!!", message: "Some fields are empty")
            return
        }
        let depositRow : TextRow? = form.rowBy(tag: "Deposit")
        let deposit = depositRow?.value ?? ""
        
        guard let amount = Double(deposit) else {
            presentAlertWithTitle(title: "Error", message: "Invalid deposit amount")
            return
        }
        
        let amountChange = AmountChange(amount: amount)
        
        NetworkManager.shared.deposit(token: usertoken ?? "" , amountChange: amountChange) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(_):
                    let profileVC = ProfileViewController()
                    
                    self.dismiss(animated: true, completion: nil)
                    
                case .failure(let error):
                    print(error)
                    self.presentAlertWithTitle(title: "Error", message: "Failed to deposit. Please try again.")
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

