//
//  FirstPage.swift
//  EventChat
//
//  Created by Lau on 26/12/2023.
//

import SwiftUI

struct FirstPage:View{
    @EnvironmentObject var model:Model
    
    var body: some View{
        Button{
            model.submitMessage()
        }label: {
            Image(systemName: "paperplane.fill")
            
        }
        .font(.system(size: 50))
        .padding(.horizontal,10)
    }
}
