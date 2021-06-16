//
//  ViewController.swift
//  Messenger
//
//  Created by meng on 2021/06/16.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        if !isLoggedIn {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            //true로 하면 좀더 보여지는 시간이 길어 이전 화면을 볼 수 있는데 false로하면 띄울 화면만 보여짐.
            present(nav, animated: false)
        }
    }


}

