//
//  NotificationViewModel.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 10/05/2021.
//

import UIKit

struct NotificationViewModel {
    var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? {
        URL(string: notification.postImageUrl ?? "")
    }
    
    var profileImageUrl: URL? {
        URL(string: notification.userProfileImageUrl ?? "")
    }
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date())
    }
    
    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.nofificationMessage
        
        let attribudetText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attribudetText.append(NSAttributedString(string: message, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)]))
        attribudetText.append(NSAttributedString(string: "   \(timestampString ?? "2m")", attributes: [.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        return attribudetText
    }
    
    var shouldHidePostImage: Bool {
        return notification.type == .follow
    }
    
    var followButtonText: String {
        return notification.userIsFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackground: UIColor {
        return notification.userIsFollowed ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return notification.userIsFollowed ? .black : .white
    }
}

