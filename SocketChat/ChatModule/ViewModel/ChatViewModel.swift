//
//  ChatViewModel.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import Foundation

protocol ChatViewModel {
    func sendMessage(_ message: String)
    func connect()  
}

class DefaultChatViewModel: ChatViewModel {
    // MARK:- Properties
    let networkService: NetworkService?
    
    // MARK:- Functions
    func sendMessage(_ message: String) {
        guard let username = UserDefaults.standard.string(forKey: "username") else { return }
        let message = Message(username: username, message: message)
        do {
            let json = try JSONEncoder().encode(message)
            guard let jsonString = String(data: json, encoding: .utf8) else { return }
            networkService?.send(message: jsonString)
        } catch {
            print(error)
        }
    }
    
    func connect() {
        networkService?.connect()
    }
    
    // MARK:- Init
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}
