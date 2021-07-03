//
//  AuthViewController.swift
//  SocketChat
//
//  Created by Максим Алексеев on 28.06.2021.
//

import UIKit

class AuthViewController: UIViewController {
    // MARK:- Properties
    var authView: AuthView {
        return view as! AuthView
    }
    
    var viewModel: AuthViewModel! 
    
    // MARK:- Lifecycle
    override func loadView() {
        view = AuthView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let socketService = SocketService()
        let networkService = DefaultNetworkService(socketService: socketService)
        networkService.connect()
        
        authView.enterButton.addTarget(self, action: #selector(didPressEnterButton), for: .touchUpInside)
    }

    // MARK:- Setup
    
    // MARK:- Selectors
    @objc func didPressEnterButton() {
        
    }
}

