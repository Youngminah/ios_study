//
//  DatabaseManager.swift
//  Messenger
//
//  Created by meng on 2021/06/18.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager() //싱글톤
    private let database = Database.database().reference()
}

//MARK: Account Management
extension DatabaseManager{
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false) //이곳에서 리턴 false를 주어야하기 때문에 이스케이핑을 쓴 것.
                return
            }
        })
        completion(true)
    }
    
    
    // Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePictureUrl: String
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
