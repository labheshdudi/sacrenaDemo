//
//  TabBarViewController.swift
//  SacrenaDemo
//
//  Created by Labhesh Dudi on 13/09/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    let chatList: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViewController()
    }
    
    init(chatList: UIViewController) {
        self.chatList = chatList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpViewController() {
        let nav1 = UINavigationController(rootViewController: chatList)
        
        nav1.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "message"), tag: 0)
        setViewControllers([nav1], animated: true)
    }
    
}
