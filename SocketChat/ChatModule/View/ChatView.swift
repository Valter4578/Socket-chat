//
//  ChatView.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import UIKit

class ChatView: UIView {
    // MARK:- Views
    lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write a message..."
        textField.textColor = .lightText
        textField.font = .systemFont(ofSize: 16)
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.leftView = spacerView
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        let image = UIImage(named: "send")!
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var toolBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupToolBarView()
        setupSendButton()
        setupMessageTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sendButton.layer.cornerRadius = sendButton.frame.height / 2
        
        messageTextField.layer.cornerRadius = 15
        messageTextField.layer.borderColor = UIColor.lightGray.cgColor
        messageTextField.layer.borderWidth = 1
    }
    
    // MARK:- Setups
    private func setupToolBarView() {
        addSubview(toolBarView)
        NSLayoutConstraint.activate([
            toolBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            toolBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            toolBarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            toolBarView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setupSendButton() {
        addSubview(sendButton)
        NSLayoutConstraint.activate([
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.centerYAnchor.constraint(equalTo: toolBarView.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: toolBarView.trailingAnchor, constant: -15),
        ])
    }
    
    private func setupMessageTextField() {
        addSubview(messageTextField)
        NSLayoutConstraint.activate([
            messageTextField.leadingAnchor.constraint(equalTo: toolBarView.leadingAnchor, constant: 5),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -15),
            messageTextField.topAnchor.constraint(equalTo: toolBarView.topAnchor, constant: 10),
            messageTextField.bottomAnchor.constraint(equalTo: toolBarView.bottomAnchor, constant: -10),
        ])
    }
}
