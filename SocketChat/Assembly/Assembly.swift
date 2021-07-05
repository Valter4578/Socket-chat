//
//  Assembly.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import Foundation

protocol Assembly {
    func configureAuthModule(coordinator: AuthCoordinator) -> AuthViewController
    func configureChatModule(coordinator: ChatCoordinator) -> ChatViewController
}

class DefaultAssembly: Assembly {
    func configureAuthModule(coordinator: AuthCoordinator) -> AuthViewController {
        let viewController = AuthViewController()
        let viewModel = DefaultAuthViewModel()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        return viewController
    }

    func configureChatModule(coordinator: ChatCoordinator) -> ChatViewController {
        let viewController = ChatViewController()
        let networkService = DefaultNetworkService() 
        let viewModel = DefaultChatViewModel(networkService: networkService)
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        return viewController
    }
}
