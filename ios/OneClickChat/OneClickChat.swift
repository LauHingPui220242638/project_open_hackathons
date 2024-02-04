//
//  EventChatApp.swift
//  EventChat
//
//  Created by Lau on 26/12/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {


    return GIDSignIn.sharedInstance.handle(url)
  }
}


@main
struct OneClickChat: App {
    init() {
           FirebaseApp.configure()
       }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
