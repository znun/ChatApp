//
//  FirebaseUserListener.swift
//  ChatApp
//
//  Created by Xunnun on 13/3/22.
//

import Foundation
import Firebase

class FirebaseUserListener {
    static let shared = FirebaseUserListener()
    
    private init () { }
        
        //MARK: - Login
        
        //MARK: - Register
        func registerUserWith(email:String, password:String, completion: @escaping(_ error: Error?) -> Void) {
            Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
                completion(error)
                
                //send verification email
                if error == nil {
                    authDataResult!.user.sendEmailVerification { (error) in
                        print("auth email sent with error :", error?.localizedDescription)
                    }
                    
                 //create user and save it
                    
                    if authDataResult?.user != nil {
                        
                        let user = User(id: authDataResult!.user.uid, username: email, email: email, pushId: "", avatarLink: "", status: "Hey there I'm using chatting app")
                        
                        saveUserLocally(user)
                        self.saveUserToFirestore(user)
                    
                    }
                }
            }
        }
    //MARK: - Save users
    func saveUserToFirestore(_ user: User) {
        
        do {
            try FirebaseReference(.User).document(user.id).setData(from: user)
        } catch {
            print(error.localizedDescription, "ading user")
        }
        
    }
}
