//
//  ChatViewController.swift
//  SocketChat
//
//  Created by Максим Алексеев on 03.07.2021.
//

import UIKit

class ChatViewController: UIViewController {
    // MARK:- Dependencies
    var chatView: ChatView {
        return view as! ChatView
    }
    
    var viewModel: ChatViewModel!
    var coordinator: ChatCoordinator!
    
    // MARK:- Private properties
    private let cellId = "ChatViewControllerTableViewCell"
    
    // MARK:- Lifecycle
    override func loadView() {
        view = ChatView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.connect()
        viewModel.receive()
        chatView.sendButton.addTarget(self, action: #selector(didPressSendButton), for: .touchUpInside)
        configureTableView()
    }
    
    // MARK:- Private
    private func bindViewModel() {
        viewModel.messagesDidChange = { [weak self] viewModel in
            guard let strongSelf = self else { return }
            strongSelf.chatView.messagesTableView.reloadData()
        }
    }
    
    private func configureTableView() {
        chatView.messagesTableView.delegate = self
        chatView.messagesTableView.dataSource = self
        chatView.messagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    // MARK:- Selectors
    @objc func didPressSendButton() {
        guard let message = chatView.messageTextField.text,
              !message.isEmpty
        else { return }
        
        viewModel.send(message: message)
        chatView.messageTextField.text = ""
    }
}

// MARK:- UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    
}

// MARK:- UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = viewModel.messages[indexPath.row].message
        return cell
    }
}
