//
//  UserService.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 22/03/2021.
//

import Firebase

struct UserService {
    
    static func fetchUser(complition: @escaping(User) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            complition(user)
        }
    }
}
