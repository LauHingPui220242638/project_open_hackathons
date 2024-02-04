//
//  FirstPage.swift
//  EventChat
//
//  Created by Lau on 26/12/2023.
//

import SwiftUI



struct SecondPage:View{
    
    
    @EnvironmentObject var model:Model
    
    
    var body: some View{
        
        VStack {
            
            ScrollView{
                ForEach($model.messages.indices, id: \.self){
                    index in ChatDialog(chat:model.messages[index])
                    
                    
                }
            }
            
        
            
            HStack {
                TextField("Ask Something", text: $model.messageText)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10.0)
                    .onSubmit {
                        model.submitMessage()
                    }
                        

                
                
                Button{
                    model.submitMessage()
                }
                label: {
                    Image(systemName: "paperplane.fill")
                    
                }
                .font(.system(size: 26))
                .padding(.horizontal,10)
                
            }
            .padding(.bottom,40)
            .padding(.horizontal,10)
        }
        
    }
    
    
    
    
}

struct SecondContentView: View {
    
    @StateObject var model = Model()
    
    

    var body: some View {
        ZStack{
            SecondPage()
        }.environmentObject(model)
        
            
        
    }
}

struct SecondPageView_Previews: PreviewProvider {
    static var previews: some View {
        SecondContentView()
    }
}
