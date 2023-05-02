//
//  UserModel.swift
//  test
//
//  Created by 醫 on 23/3/2023.
//

import Foundation

struct UserModel: Identifiable {
    
    let id: String = UUID().uuidString
    let email: String
    let name: String
    let rank: Int
    let membership: Bool

}
