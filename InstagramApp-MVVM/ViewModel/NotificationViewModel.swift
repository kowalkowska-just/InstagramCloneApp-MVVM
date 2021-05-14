//
//  NotificationViewModel.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 10/05/2021.
//

import UIKit

struct NotificationViewModel {
    private let notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? {
        URL(string: notification.postImageUrl ?? "")
    }
    
    var profileImageUrl: URL? {
        URL(string: notification.userProfileImageUrl ?? "")
    }
    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.nofificationMessage
        
        let attribudetText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attribudetText.append(NSAttributedString(string: message, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)]))
        attribudetText.append(NSAttributedString(string: "   2m", attributes: [.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        return attribudetText
    }
    
    var shouldHidePostImage: Bool {
        return notification.type == .follow
    }
}

