//
//  NetworkService.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import Foundation

protocol NetworkService {
    var delegate: NetworkServiceDelegate? { get set }
    func connect()
    func close()
    func receive()
    func send(message: String)
}

protocol NetworkServiceDelegate: AnyObject {
    func received(message: Message)
}

class DefaultNetworkService: NSObject, NetworkService {
    // MARK:- Private Properties
    private var session: URLSession?
    private var webSocketTask: URLSessionWebSocketTask?
    
    // MARK:- Properties
    weak var delegate: NetworkServiceDelegate?
    
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
    
    func send(message: String) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.webSocketTask?.send(.string(message)) { error in
                if let error = error {
                    print("Error when sending a message \(error)")
                }
            }
        }
    }
    
    func receive() {
        webSocketTask?.receive { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Data received \(data)")
                    guard let message = try? JSONDecoder().decode(Message.self, from: data) else { return }
                    strongSelf.delegate?.received(message: message)
                case .string(let text):
                    print("Text received \(text)")
                    guard let data = text.data(using: .utf8),
                          let message = try? JSONDecoder().decode(Message.self, from: data)
                    else { return }
                    strongSelf.delegate?.received(message: message)
                @unknown default:
                    fatalError("Unexpected message output in receive")
                }
            case .failure(let error):
                print("Error when receiving \(error)")
            }
            
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
