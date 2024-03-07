//
//  ViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import UIKit
import Eureka


class HomeViewController: FormViewController {
    let welcomeLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(welcomeLabel)
        setupUI()
        configureForm()
       
    }
    
    private func configureForm() {
        form +++ Section()
        form +++ Section()
        form +++ Section()
        form +++ Section()
        form +++ Section()
        form +++ Section()
        form +++ Section()
        form +++ Section()
        form +++ Section()
        form +++ Section()
        form +++ Section()
        



        <<< ButtonRow() { row in
            row.title = "Sign Up"
        }.cellUpdate { cell, _ in
            self.configureButtonCell(cell)
            cell.backgroundColor = .clear;
            cell.selectionStyle = .none
            cell.textLabel?.textColor = UIColor(red: 34/255, green: 134/255, blue: 58/255, alpha: 1.0)
            
        }.onCellSelection { [weak self] _, _ in
            self?.signUpButtonTapped()
        }
        form +++ Section()

        <<< ButtonRow() { row in
            row.title = "Sign In"
        }.cellUpdate { cell, _ in
            self.configureButtonCell(cell)
            cell.backgroundColor = .clear; 
            cell.selectionStyle = .none
            cell.textLabel?.textColor = UIColor(red: 34/255, green: 134/255, blue: 58/255, alpha: 1.0)
        }.onCellSelection { [weak self] _, _ in
            self?.signInButtonTapped()
        }
    }
    
    private func setupUI() {
           
        let imageView = UIImageView(image: UIImage(named: "kfh"))
                imageView.contentMode = .scaleAspectFit
                view.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(100)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(200)
                    make.height.equalTo(200)
                }

                
                welcomeLabel.text = "Welcome to KFH!"
                welcomeLabel.font = UIFont.boldSystemFont(ofSize: 27)
        welcomeLabel.textColor = UIColor(red: 34/255, green: 134/255, blue: 58/255, alpha: 1.0)
                welcomeLabel.textAlignment = .center
                view.addSubview(welcomeLabel)
                welcomeLabel.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(imageView.snp.bottom).offset(20)
                }
            }
    

    private func configureButtonCell(_ cell: ButtonCellOf<String>) {
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.backgroundColor = .lightGray
        cell.tintColor = .white
       
    }

    
    @objc private func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc private func signInButtonTapped() {
        let signInVC = LoginViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
}
