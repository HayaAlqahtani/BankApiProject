import Foundation
import Alamofire
import Foundation
import Alamofire

class NetworkManager {
    private let baseUrl = "https://coded-bank-api.eapi.joincoded.com/"
    
    static let shared = NetworkManager()
    
    func signup(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "signup"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    func signin(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "signin"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    
    func deposit(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "deposit"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    func withdraw(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "withdraw"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getTransactions(token: String, completion: @escaping (Result<[Transaction], Error>) -> Void) {
        let url = baseUrl + "transactions"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(url, headers: headers).responseDecodable(of: [Transaction].self) { response in
            switch response.result {
            case .success(let transactions):
                completion(.success(transactions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUserDetails(token: String, completion: @escaping (Result< UserDetails, Error>) -> Void) {
        let url = baseUrl + "account"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, headers: headers).responseDecodable(of: UserDetails.self ){response in
            switch response.result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
        
    }
}
