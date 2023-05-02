//
//  testApp.swift
//  test
//
//  Created by 醫 on 13/3/2023.
//

import SwiftUI

@main
struct testApp: App {
    
    @StateObject var userViewModel: UserViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            LoginView()
                .environmentObject(userViewModel)
        }
    }
}
