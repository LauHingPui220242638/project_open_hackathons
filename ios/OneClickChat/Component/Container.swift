//
//  Container.swift
//  EventChat
//
//  Created by Lau on 26/12/2023.
//


import SwiftUI



struct Container<Content: View>: View {
    @ViewBuilder let content: Content
   
    var body: some View{
        VStack{
            
            Spacer()
            content
            Spacer()
            
        }
        
    }
}
