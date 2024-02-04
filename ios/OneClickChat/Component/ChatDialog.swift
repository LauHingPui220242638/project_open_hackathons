//
//  ChatDialog.swift
//  EventChat
//
//  Created by Lau on 27/12/2023.
//

import SwiftUI

struct ChatText:View{
    var messageText:String
    var body:some View{
        Text(messageText)
            .padding()
            .foregroundColor(.white)
            .background(.blue.opacity(0.8))
            .cornerRadius(5)
            .padding(.horizontal,20)
            
    }
}

struct ChatDialog:View{
    var chat:Chat
    var body: some View{
        
        HStack{
            if chat.sender == "AI" {Spacer()}
                ChatText(messageText: chat.message)
            if chat.sender != "AI" {Spacer()}
        }
    }
            
}
