//
//  SingUpViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Haya Alqahtani on 06/03/2024.
//

import UIKit
import Eureka

class SignUpViewController: FormViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpForm()
        
    }
    
    private func signUpForm(){
        
        form +++ Section("SignUp")
        
        <<< EmailRow() { row in
            row.title = "Email"
            row.placeholder = "Enter Your Email"
            row.tag = "Email"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< TextRow() {row in
            row.title = "UserName"
            row.placeholder = "Enter Your Name"
            row.tag = "Name"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< PasswordRow() { row in
            row.title = "Password"
            row.placeholder = "Enter Your Password"
            row.tag = "Password"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        +++ Section("   ")
        <<< ButtonRow() { row in
            row.title = "Sign Up"
            row.onCellSelection { cell, row in
                print("button cell tapped")
                self.submitTapped()
            }
        }
        
    }
    
    @objc func submitTapped(){
        
        let errors = form.validate()
        guard errors.isEmpty else{
            print("Somthing is missing!")
            print(errors)
            let countError = errors.count
            presentAlertWithTitle(title: "error!!", message: " \(countError) TextFields empty")
            return
        }
        
        let emailRow : EmailRow? = form.rowBy(tag: "Email")
        let email = emailRow?.value ?? ""
        
        let nameRow: TextRow? = form.rowBy(tag: "Name")
        let name = nameRow?.value ?? ""
        
        let passwordRow: PasswordRow? = form.rowBy(tag: "Password")
        let password = passwordRow?.value ?? ""
        
        let user = User(username: name, email: email, password: password)
        print("signup ",user)
        
        NetworkManager.shared.signup(user: user) { success in
            DispatchQueue.main.async {
                switch success{
                case .success(let tokenResponse):
                    print(tokenResponse.token)
                    
                    // Navigation
                    
                    let profileVC = ProfileViewController()
                    profileVC.token = tokenResponse.token
                    self.navigationController?.pushViewController(profileVC, animated: true)
                    
                case .failure(let error):
                    print(error)
                }
                
            }
        }
        
        
        func presentAlertWithTitle(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
    }
    
}
