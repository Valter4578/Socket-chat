//
//  Message.swift
//  SocketChat
//
//  Created by Максим Алексеев on 01.07.2021.
//

import Foundation

struct Message: Codable {
    let username: String
    let message: String 
}
