//
//  ChatCoordinator.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import UIKit

class ChatCoordinator: Coordinator {
    // MARK:- Properties
    var childCoordinators: [Coordinator] = []
    var viewController: UIViewController?
    let assembly: Assembly
    
    // MARK:- Functions
    func start() {
        viewController = assembly.configureChatModule(coordinator: self)
    }
    
    // MARK:- Init
    init(assembly: Assembly) {
        self.assembly = assembly
    }
}
