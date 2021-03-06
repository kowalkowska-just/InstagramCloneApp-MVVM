//
//  UserService.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 22/03/2021.
//

import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
        
    static func fetchUser(withUid uid: String, complition: @escaping(User) -> Void) {
                
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            complition(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping(FirestoreCompletion)) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { (error) in
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: @escaping(FirestoreCompletion)) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { (error) in
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { (snapshot, error) in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    static func fetchUserState(uid: String, completion: @escaping(UserState) -> Void) {
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapshot, _) in
            let followers = snapshot?.documents.count ?? 0
            
            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { (snapshot, _) in
                let following = snapshot?.documents.count ?? 0
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { (snapshot, _) in
                    let posts = snapshot?.documents.count ?? 0
                
                    completion(UserState(followers: followers, following: following, posts: posts))
                }
            }
        }
    }
    
    static func fetchFollowers(forUser uid: String, completion: @escaping([User]) -> Void) {
        
        var followers = [User]()
        
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, error in
            
            guard let snapshot = snapshot else { return }
            
            snapshot.documents.forEach({ document in
                fetchUser(withUid: document.documentID) { follower in
                    followers.append(follower)
                    completion(followers)
                }
            })
        }
    }
    
    static func fetchFollowing(forUser uid: String, completion: @escaping([User]) -> Void) {
        
        var usersFollowing = [User]()
        
        COLLECTION_FOLLOWERS.document(uid).collection("user-following").getDocuments { snapshot, error in
            
            guard let snapshot = snapshot else { return }
            
            snapshot.documents.forEach({ document in
                fetchUser(withUid: document.documentID) { userFollowing in
                    usersFollowing.append(userFollowing)
                    completion(usersFollowing)
                }
            })
        }
    }
}
