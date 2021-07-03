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
        viewController = assembly.configureAuthModule()
    }
    
    
    init(assembly: Assembly) {
        self.assembly = assembly
    }
}
