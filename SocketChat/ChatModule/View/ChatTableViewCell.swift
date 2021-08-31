//
//  ChatTableVIewCell.swift
//  SocketChat
//
//  Created by Максим Алексеев on 06.07.2021.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    // MARK:- Properties
    var message: Message? {
        didSet {
            messageLabel.text = message?.message
            if let isOutcoming = message?.isOutcoming {
                isOutcoming ? setupOutcoming() : setupIncoming()
            }
        }
    }
    
    // MARK:- Private properties
    private var leadingMessageAnchor: NSLayoutConstraint!
    private var trailingMessageAnchor: NSLayoutConstraint!
    
    // MARK:- Views
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0 
        return label
    }()
    
    lazy var messageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK:- Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemGray
        
        addSubview(messageView)
        setupLabel()
        setupMessageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- Private functions
    private func setupOutcoming() {
        trailingMessageAnchor.isActive = true
        leadingMessageAnchor.isActive = false
        messageView.backgroundColor = .purple
        messageLabel.textColor = .white
    }
    
    private func setupIncoming() {
        trailingMessageAnchor.isActive = false
        leadingMessageAnchor.isActive = true
        messageView.backgroundColor = .white
    }
    
    // MARK:- Setups
    private func setupLabel() {
        addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
        trailingMessageAnchor = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        leadingMessageAnchor = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
    }
    
    private func setupMessageView() {
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -10),
            messageView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -10),
            messageView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 10),
            messageView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10)
        ])
    }
}
