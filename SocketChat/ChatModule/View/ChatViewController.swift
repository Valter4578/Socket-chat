//
//  ChatViewController.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import UIKit

class ChatViewController: UIViewController {
    // MARK:- Dependencies
    var chatView: ChatView {
        return view as! ChatView
    }
    
    var viewModel: ChatViewModel!
    var coordinator: ChatCoordinator!
    
    // MARK:- Lifecycle
    override func loadView() {
        view = ChatView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.connect()
        chatView.sendButton.addTarget(self, action: #selector(didPressSendButton), for: .touchUpInside)
    }
    
    // MARK:- Functions
    
    // MARK:- Selectors
    @objc func didPressSendButton() {
        guard let message = chatView.messageTextField.text,
              !message.isEmpty
        else { return }
        
        viewModel.send(message: message)
        chatView.messageTextField.text = ""
    }
}
