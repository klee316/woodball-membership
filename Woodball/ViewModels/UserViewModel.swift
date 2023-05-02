//
//  UserViewModel.swift
//  test
//
//  Created by 醫 on 23/3/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var users: [UserModel] = []
    
    init() {
        getUser()
    }
    
    
    func getUser() {
        
        let newUsers = [
            UserModel(email: "master@gmail.com", name: "Master Yoda", rank: 1, membership: true),
            UserModel(email: "princefrog@gmail.com", name: "Prince Frog", rank: 11, membership: true),
            UserModel(email: "woody@gmail.com", name: "Woody", rank: 11, membership: false)
        ]
        
        users.append(contentsOf: newUsers)
        
    }
    
    func checkValidEmail(email: String) -> Bool {
        
        let result = users.filter { $0.email == email }
        
        let exists = !result.isEmpty
        
        return exists
    }
    
    func checkPassword(email: String, password: String) -> Bool {
        
        let result = users.filter { $0.email == email && $0.name == password }
        
        let exists = !result.isEmpty
        
        return exists
    }
    
    func loggedIn(email: String, password: String) -> UserModel? {
        
        if let index = users.firstIndex(where: { $0.email == email && $0.name == password }) {
            return users[index]
        }
        return nil
    }
}
