//
//  TransactionsViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Haya Alqahtani on 06/03/2024.
//

import UIKit
import SnapKit
import Alamofire
import Eureka

class TransactionsViewController: UITableViewController {
    
    private var transactions: [Transaction] = []
    var userToken: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        fetchTransactions()
    }
    
    
    
    private func fetchTransactions() {
        print("Fetching transactions...")
        NetworkManager.shared.getTransactions(token: self.userToken!) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let transactions):
                    print("Transactions received: \(transactions)")
                    self.transactions = transactions
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Failed to fetch transactions: \(error)")
                }
            }
        }
    }
    override   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = "Type: \(transaction.type), Amount: \(transaction.amount)"
        
        return cell
    }
    
}


