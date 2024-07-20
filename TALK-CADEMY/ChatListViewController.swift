//
//  ChatListViewController.swift
//  TALK-CADEMY
//
//  Created by NERO on 7/19/24.
//

import UIKit

struct ChatInfo: Hashable, Identifiable {
    let id = UUID()
    let user: String
    let profile: UIImage
    let message: String
    let date: Date
}

final class ChatListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
