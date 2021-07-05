//
//  ChatViewController.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import UIKit

class ChatViewController: UIViewController {
    // MARK:- Dependencies
    var chatView: UIView {
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
        
        
    }
    
    // MARK:- Functions
    
}
