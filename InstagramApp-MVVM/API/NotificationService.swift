//
//  NotificationService.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 05/05/2021.
//

import Firebase

struct NotificationService {
    
    static func uploadNotification(toUser uid: String, type: NotificationType, post: Post? = nil) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard uid != currentUid else { return }
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "uid": currentUid,
                                   "type": type.rawValue]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").addDocument(data: data)
        
    }
    
    static func fetchNotification() {
        
    }
}
