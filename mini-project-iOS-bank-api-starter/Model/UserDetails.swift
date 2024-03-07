//
//  UserDetails.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Haya Alqahtani on 07/03/2024.
//

import Foundation
struct UserDetails: Decodable {
    let username: String
    let email: String
    let password: String
    let balance: Double
    let id: Int
    
}
