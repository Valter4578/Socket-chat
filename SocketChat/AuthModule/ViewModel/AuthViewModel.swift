//
//  AuthViewModel.swift
//  SocketChat
//
//  Created by Максим Алексеев on 28.06.2021.
//

import Foundation

protocol AuthViewModel {
    func saveUsername(_ username: String)
}

class DefaultAuthViewModel: AuthViewModel {
    // MARK:- Properties

    // MARK:- Functions
    func saveUsername(_ username: String) {
        UserDefaults.standard.setValue(username, forKey: "username")
    }
    
    // MARK:- Private functions
    
    // MARK:- Init
    
}
