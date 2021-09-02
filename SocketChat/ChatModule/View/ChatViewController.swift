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
    private enum Constants {
        static let cellId = "ChatViewControllerTableViewCellId"
//        static let cellHeight = 50
//        static let cellWidth = 300
        static let minimumLineSpacing = 10
    }
    
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
        configureCollectionView()
    }
    
    // MARK:- Private
    private func bindViewModel() {
        viewModel.messagesDidChange = { [weak self] viewModel in
            guard let strongSelf = self else { return }
            strongSelf.chatView.messagesCollectionView.reloadData()
        }
    }
    
    private func configureCollectionView() {
        chatView.messagesCollectionView.delegate = self
        chatView.messagesCollectionView.dataSource = self
        chatView.messagesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellId)
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

// MARK:- UICollectionViewDelegate
extension ChatViewController: UICollectionViewDelegate {
    
}

// MARK:- UICollectionViewDataSource
extension ChatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Constants.minimumLineSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let top = Int(chatView.messagesCollectionView.frame.height) - (50 + Constants.minimumLineSpacing) * viewModel.messages.count
        return UIEdgeInsets(top: CGFloat(top), left: 5, bottom: 5, right: 5)
    }
}
