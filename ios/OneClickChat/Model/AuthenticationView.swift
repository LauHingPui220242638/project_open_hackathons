//
//  GoogleSignInModel.swift
//  OneClickChat
//
//  Created by Lau on 1/2/2024.
//

import SwiftUI

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift



@MainActor
final class AuthenticationViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var logged:Bool = false
    
    func GoogleSignIn()async throws{
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first
                  as? UIWindowScene)?.windows.first?.rootViewController
              else {return}
        
        
        // Start the sign in flow!
        let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
        

        let user = userAuthentication.user
        guard let idToken = user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        

        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
        let authData = try await AuthenticationManager.shared.signInGoogle(credential: credential)
        print(authData)
        
        
    }
}



