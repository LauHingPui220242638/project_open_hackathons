//
//  AuthenticationManager.swift
//  OneClickChat
//
//  Created by Lau on 1/2/2024.
//

import FirebaseAuth

import Combine

struct AuthDataModel {
    let uid : String
    let email : String?
    let photoUrl : String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}


final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private init(){
    }
    
    func getAuthenticatedUser() throws -> AuthDataModel{
        guard let user = Auth.auth().currentUser  else{
            throw URLError(.badServerResponse)
        }
        
        return AuthDataModel(user: user)
    }
    
    
}

extension AuthenticationManager{
    
    func signUp(email:String, password:String) {
        Auth.auth().createUser(withEmail: email, password: password){
            result, error in if error != nil{
                print(error!.localizedDescription)
                
            }
        }
    }
    
    func signIn(email:String, password:String, model:Model)throws -> Bool{
        try Auth.auth().signIn(withEmail: email, password: password) {
            result, error in if error != nil{
                print(error?.localizedDescription)
                print(result)
                
            }
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let email = user.email
            // You can access other user properties as well, such as displayName, photoURL, etc.
            
            // Use the user information as needed
            print("Signed-in user: UID - \(uid), Email - \(email ?? "")")
            
            model.userName = email
            return true
            
        } else {
            // No user is signed in
            print("No user signed in")
            return false
        }

    }
    
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            // Sign out successful
            print("User signed out successfully")
        } catch {
            // An error occurred while signing out
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

extension AuthenticationManager{
    
    func signInGoogle(credential:AuthCredential) async throws -> AuthDataModel{
        let authData = try await Auth.auth().signIn(with: credential)
        return AuthDataModel(user:authData.user)
    }
}
