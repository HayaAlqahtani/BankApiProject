//
//  ProfileViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Haya Alqahtani on 06/03/2024.
//
import UIKit
import SnapKit
import Kingfisher
import Alamofire
import SwiftUI

class ProfileViewController: UIViewController {
    var token: String?
    var user: User?
    
    let imageView = UIImageView()
    let immageView2 = UIImageView()
    
    let nameLabel = UILabel()
    private var emailLabel = UILabel()
    private let balanceLabel = UILabel()
    private let depositButton = UIButton()
    private let withdrawButton = UIButton()
    private let transactionButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.86, green: 0.96, blue: 0.86, alpha: 1.00)
        super.viewDidLoad()
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(balanceLabel)
        view.addSubview(depositButton)
        view.addSubview(withdrawButton)
        view.addSubview(transactionButton)
        view.addSubview(imageView)
        view.addSubview(immageView2)
        fetchUserDetails()
        setupConstraints()
        configureUI()
        setupConstraints()
        setupNavBar()
    }
    
    
    private func setupConstraints(){
        imageView.snp.makeConstraints { make in
            make.top.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(280)
            make.width.equalTo(450)
            
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(-10)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
        }
        depositButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-100)
            make.top.equalTo(balanceLabel.snp.bottom).offset(50)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(100)
            make.top.equalTo(balanceLabel.snp.bottom).offset(50)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        transactionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            transactionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            transactionButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 20),
            transactionButton.widthAnchor.constraint(equalToConstant: 50),
            transactionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        immageView2.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(170)
            make.width.equalTo(400)
        }
        
    }
    
     func fetchUserDetails() {
         guard let token = token else {
             print("no token found")
             return
         }
        
        NetworkManager.shared.getUserDetails(token: token) {  result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.configureUI()
                    self.balanceLabel.text = String(user.balance)
                    self.nameLabel.text = "🙍🏻‍♀️ UserName:  \(user.username)"
                    self.nameLabel.textColor = .darkGray
                    self.emailLabel.text = "📧 Email:   \(user.email)"
                    self.nameLabel.textColor = .darkGray
                    self.updatedata()
                    
                case .failure(let error):
                    print("Failed to fetch user details: \(error)")
                }
            }
        }
    }
    
    
    private func configureUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "traced-C")
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.textColor = .black
        
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        
        
        balanceLabel.textAlignment = .center
        balanceLabel.font = UIFont.systemFont(ofSize: 16)
        
        
        depositButton.setTitle("💵 Deposit", for: .normal)
        depositButton.setTitleColor(.darkGray, for: .normal)
        depositButton.backgroundColor = .white
        depositButton.layer.cornerRadius = 5
        depositButton.addTarget(self, action: #selector(depositButtonTapped), for: .touchUpInside)
        
        
        
        withdrawButton.setTitle("💸 Withdraw", for: .normal)
        withdrawButton.setTitleColor(.darkGray, for: .normal)
        withdrawButton.backgroundColor = .white
        withdrawButton.layer.cornerRadius = 5
        withdrawButton.addTarget(self, action: #selector(withdrawButtonTapped), for: .touchUpInside)
        view.addSubview(withdrawButton)
        
        immageView2.contentMode = .scaleAspectFill
        immageView2.clipsToBounds = true
        immageView2.image = UIImage(named: "kfhfaten")
        
        transactionButton.setImage(UIImage(named: "transaction_icon"), for: .normal)
        transactionButton.addTarget(self, action: #selector(transactionButtonTapped), for: .touchUpInside)
        
        
        
        
    }
    
    // MARK: - Actions
    
    @objc private func depositButtonTapped() {
        let DepositVC = DepositViewController()
        if let sheet = DepositVC.sheetPresentationController {
            sheet.detents = [.medium(), .medium()]
            
            
            DepositVC.modalPresentationStyle = .popover
            DepositVC.usertoken = token
        }
        self.present(DepositVC, animated: true)
        
    }
    
    @objc private func withdrawButtonTapped() {
        let WithdrawVC = WithdrawViewController()
        if let sheet = WithdrawVC.sheetPresentationController {
            sheet.detents = [.medium(), .medium()]
            
            WithdrawVC.modalPresentationStyle = .popover
            WithdrawVC.usertoken = token
        }
        self.present(WithdrawVC, animated: true)
        
    }
    func setupNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(transactionButtonTapped)
        )
        navigationItem.rightBarButtonItem? .tintColor = UIColor.lightGray
        
    }
    @objc private func transactionButtonTapped() {
        let transactionVC = TransactionsViewController()
        transactionVC.userToken = token
        self.navigationController?.pushViewController(transactionVC, animated: true)
    }
    
}
extension ProfileViewController: UpdateDelegate{
    func updatedata() {
        fetchUserDetails()
    }
}
