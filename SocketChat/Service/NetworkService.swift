//
//  NetworkService.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import Foundation

protocol NetworkService {
    func connect()
}

class DefaultNetworkService: NetworkService {
    // MARK:- Private Properties
    private let session: URLSession
    private let socketService: SocketService
    
    // MARK:- Functions
    func connect() {
        guard let url = URL(string: "ws://localhost:5050/ws") else { return }
        let webSocketTast = session.webSocketTask(with: url)
        webSocketTast.resume()
    }
    
    // MARK:- Init
    init(socketService: SocketService) {
        self.socketService = socketService
        self.session = URLSession(configuration: .default, delegate: socketService, delegateQueue: OperationQueue())
    }
}
