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
    
    var profileImageUel: URL? {
        URL(string: notification.userProfileImageUrl ?? "")
    }
}

