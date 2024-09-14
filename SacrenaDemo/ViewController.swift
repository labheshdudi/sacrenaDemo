//
//  ViewController.swift
//  SacrenaDemo
//
//  Created by Labhesh Dudi on 13/09/24.
//

import UIKit
import StreamChat
import StreamChatUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }


    func setup() {
        ChatManager.shared.signIn { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async {
                self?.presentChatList()
            }
        }
    }
    
    func presentChatList() {
        guard let vc = ChatManager.shared.getChannelList() else { return }
        
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapCompose))
        let tabBarViewController = TabBarViewController(chatList: vc)
        tabBarViewController.modalPresentationStyle = .fullScreen
        tabBarViewController.tabBar.isHidden = true
        present(tabBarViewController, animated: true)
    }
    
    @objc func didTapCompose() {
        let alert = UIAlertController(title: "New Chat", message: "Enter Channel Name", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(.init(title: "Cancel", style: .cancel))
        alert.addAction(.init(title: "Create", style: .default, handler: { _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else {
                return
            }
            ChatManager.shared.createNewChannel(name: text)
        }))
        presentedViewController?.present(alert, animated: true)
    }
}

