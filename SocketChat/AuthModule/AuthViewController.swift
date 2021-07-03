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
        
        authView.enterButton.addTarget(self, action: #selector(didPressEnterButton), for: .touchUpInside)
    }
    
    // MARK:- Selectors
    @objc func didPressEnterButton() {
        guard let username = authView.usernameTextField.text else { return }
        viewModel.saveUsername(username)
    }
}

