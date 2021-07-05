//
//  AuthCoordinator.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import UIKit

class AuthCoordinator: Coordinator {
    var viewController: UIViewController? 
    var childCoordinators: [Coordinator] = []
    let assembly: Assembly
    
    func start() {
        viewController = assembly.configureAuthModule(coordinator: self)
    }
        
    func showChat() {
        let chatCoordinator = ChatCoordinator(assembly: assembly)
        append(coordinator: chatCoordinator)
        chatCoordinator.start()
        
        guard let chatViewController = chatCoordinator.viewController else { return }
        chatViewController.modalPresentationStyle = .fullScreen
        viewController?.present(chatViewController, animated: true)
    }
    
    init(assembly: Assembly) {
        self.assembly = assembly
    }
}
