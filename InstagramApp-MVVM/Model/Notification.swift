//
//  Notification.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 05/05/2021.
//

import Firebase

enum NotificationType: Int {
    case like
    case follow
    case comment
    
    var nofificationMessage: String {
        switch self {
        case .like: return " liked your post."
        case .follow: return " started following you."
        case .comment return "commented on your post"
        }
    }
}

struct Notification {
    
    let postId: String
    let uid: String
    let postImageUrl: String?
    let timestamp: Timestamp
    let type: NotificationType
    let notificationId: String
    
    init(dictionary: [String: Any]) {
        self.postId = dictionary["postId"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.postImageUrl = dictionary["postImageUrl"] as? String
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
    }
}
