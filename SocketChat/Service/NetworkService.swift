//
//  NetworkService.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import Foundation

protocol NetworkService {
    func connect()
    func close()
    func receive()
    func send()
}

class DefaultNetworkService: NSObject, NetworkService {
    // MARK:- Private Properties
    private var session: URLSession?
    private var webSocketTask: URLSessionWebSocketTask?
    
    // MARK:- Functions
    func connect() {
        session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        guard let url = URL(string: "ws://localhost:5050/ws") else { return }
        webSocketTask = session?.webSocketTask(with: url)
        webSocketTask?.resume()
    }
    
    func close() {
        let reason = "Closing connection".data(using: .utf8)
        webSocketTask?.cancel(with: .goingAway, reason: reason)
    }
    
    func send() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.send()
            let message = "{\"username\":\"example1\", \"message\": \"hello\"}"
            strongSelf.webSocketTask?.send(.string(message)) { error in
                if let error = error {
                    print("Error when sending a message \(error)")
                }
            }
        }
    }
    
    func receive() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Data received \(data)")
                case .string(let text):
                    print("Text received \(text)")
                }
            case .failure(let error):
                print("Error when receiving \(error)")
            }
            guard let strongSelf = self else { return }
            strongSelf.receive()
        }
    }
    
    // MARK:- Private methods
    private func ping() {
        webSocketTask?.sendPing { error in
            if let error = error {
                print("Error when sending PING \(error)")
                
            } else {
                print("Web Socket connection is alive")
                DispatchQueue.global().asyncAfter(deadline: .now() + 5) { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.ping()
                }
            }
        }
    }
}

// MARK:- URLSessionWebSocketDelegate
extension DefaultNetworkService: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Web Socket did connect")
        ping()
    }
    
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocket did disconnect")
    }
}
