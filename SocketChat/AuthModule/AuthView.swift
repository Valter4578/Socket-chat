//
//  AuthView.swift
//  SocketChat
//
//  Created by Максим Алексеев on 28.06.2021.
//

import UIKit

class AuthView: UIView {
    // MARK:- Views
    lazy var roomNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Room name"
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        button.setTitle("Enter room", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupTextField()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setup
    private func setupButton() {
        addSubview(enterButton)
        enterButton.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: roomNameTextField.bottomAnchor, constant: 20),
            enterButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            enterButton.heightAnchor.constraint(equalToConstant: 50),
            enterButton.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    private func setupTextField() {
        addSubview(roomNameTextField)
        roomNameTextField.becomeFirstResponder()
        roomNameTextField.layer.borderColor = UIColor.black.cgColor
        NSLayoutConstraint.activate([
            roomNameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            roomNameTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            roomNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            roomNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            roomNameTextField.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
