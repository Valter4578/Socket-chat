//
//  AppCoordinator.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import UIKit

class AppCoordinator: Coordinator {
    // MARK:- Properties
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    let assembly: Assembly
    
    // MARK:- Functions
    func start() {
        let authCoordinator = AuthCoordinator(assembly: assembly)
        append(coordinator: authCoordinator)
        authCoordinator.start()
        
        window.rootViewController = authCoordinator.viewController
        window.makeKeyAndVisible()
    }
    
    // MARK:- Inits
    init(window: UIWindow, assembly: Assembly) {
        self.window = window
        self.assembly = assembly
    }
}
