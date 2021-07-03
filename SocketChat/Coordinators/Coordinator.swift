//
//  Coordinator.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func append(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator } 
    }
}


