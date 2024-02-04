//
//  LoginView.swift
//  OneClickChat
//
//  Created by Lau on 1/2/2024.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift



struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var model: Model
    
    @State var LoginViewShow : Bool = true
 
    var body: some View {
        NavigationView {
                   if LoginViewShow{
                       VStack{
                           TextField("Email",text: $authViewModel.email)
                           SecureField("Password",text: $authViewModel.password)
                           Button{
                               Task {
                                       do {
                                           try await AuthenticationManager.shared.signUp(email: authViewModel.email, password: authViewModel.password)
                                       } catch {
                                           print("Error: \(error)")
                                       }
                                   }
                           }label:{
                               Text("Sign up")
                           }
                           
                           Button(action: {
                               do{
                                   try authViewModel.logged = AuthenticationManager.shared.signIn(email: authViewModel.email, password: authViewModel.password,
                                       model: model)
                                   
                               }catch{
                                   print("Error: \(error)")
                               }
                           }) {
                               Text("Log In")
                           }
                           Button{
                               AuthenticationManager.shared.signOut()
                           }label:{
                               Text("Log Out")
                           }
                           
                           GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal) ){
                               Task {
                                   do {
                                      try await authViewModel.GoogleSignIn()
                                    
                                   }
                                   catch{
                                       print(error)
                                   }
                               }
                               
                           }
                       }
                       
                       
                   } else {
                      Text("Logout")
                   }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
   
    static var previews: some View {
        LoginView()
    }
}

