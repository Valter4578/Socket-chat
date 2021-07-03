//
//  Assembly.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import Foundation

protocol Assembly {
    func configureAuthModule() -> AuthViewController
}

class DefaultAssembly: Assembly {
    func configureAuthModule() -> AuthViewController {
        let viewController = AuthViewController()
        let viewModel = DefaultAuthViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}
