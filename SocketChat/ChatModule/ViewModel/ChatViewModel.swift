//
//  ChatViewModel.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import Foundation

protocol ChatViewModel {
    var messages: [Message] { get }
    var messagesDidChange: ((ChatViewModel) -> ())? { get set }
    
    func send(message: String)
    func connect()
    func receive() 
}

class DefaultChatViewModel: ChatViewModel {
    // MARK:- Dependencies
    private var networkService: NetworkService!
    
    // MARK:- Properties
    var messages: [Message] = [] {
        didSet {
            self.messagesDidChange?(self)
        }
    }
    
    var messagesDidChange: ((ChatViewModel) -> ())?
    
    
    // MARK:- Functions
    func send(message: String) {
        guard let username = UserDefaults.standard.string(forKey: "username") else { return }
        let message = Message(username: username, message: message)
        do {
            let json = try JSONEncoder().encode(message)
            guard let jsonString = String(data: json, encoding: .utf8) else { return }
            networkService.send(message: jsonString)
        } catch {
            print(error)
        }
    }
    
    func connect() {
        networkService?.connect()
    }
    
    func receive() {
        networkService.receive()
    }
    
    // MARK:- Init
    init(networkService: NetworkService) {
        self.networkService = networkService
        self.networkService.delegate = self
    }
}

// MARK:- NetworkServiceDelegate
extension DefaultChatViewModel: NetworkServiceDelegate {
    func received(message: Message) {
        DispatchQueue.main.async {
            self.messages.append(message)
        }
    }
}
