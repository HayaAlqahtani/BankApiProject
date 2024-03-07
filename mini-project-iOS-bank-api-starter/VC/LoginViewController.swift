import UIKit
import SnapKit
import Alamofire
import Eureka

class LoginViewController: FormViewController {
    
    private let signInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInForm()
    }
    
    private func signInForm() {
        form +++ Section("Sign In")
        
        <<< TextRow() {row in
            row.title = "UserName"
            row.placeholder = "Enter your username"
            row.tag = "Name"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            
        }
        
        <<< PasswordRow() {row in
            row.title = "Password"
            row.placeholder = "Enter your password"
            row.tag = "Password"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
        }
        
        +++ Section("")
        <<< ButtonRow() { row in
            row.title = "Sign in"
            row.onCellSelection { cell, row in
                print("button cell tapped")
                self.submitInTapped()
            }}
    }
    
    
    @objc func submitInTapped(){
        
        let errors = form.validate()
        guard errors.isEmpty else{
            print("Somthing is missing!")
            print(errors)
            let countError = errors.count
            presentAlertWithTitle(title: "error!!", message: " \(countError) TextFields empty")
            return
        }
        
        let nameRow: TextRow? = form.rowBy(tag: "Name")
        let name = nameRow?.value ?? ""
        
        let passwordRow: PasswordRow? = form.rowBy(tag: "Password")
        let password = passwordRow?.value ?? ""
        
        print(password)
        
        let user = User(username: name, email: "", password: password)
        
        print(user)
        
        NetworkManager.shared.signin(user: user) { result in
            
            switch result{
            case .success(let tokenResponse):
                print(tokenResponse.token)
                
                let profileVC = ProfileViewController()
                profileVC.token = tokenResponse.token
                self.navigationController?.pushViewController(profileVC, animated: true)
                
            case .failure(let error):
                print(error)
            }
            
        }
        
        
        
        func presentAlertWithTitle(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
    }
    
}

