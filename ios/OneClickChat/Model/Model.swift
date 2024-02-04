//
//  Model.swift
//  EventChat
//
//  Created by Lau on 27/12/2023.
//


import SwiftUI
import Firebase
import FirebaseFirestore

class Model : ObservableObject{
    @Published var messageText: String = ""
    @Published var messages: [Chat] = []
    @Published var userName : String?
    
    init(){
        
        self.messages.append(Chat(message: "Welcome", sender: "AI", time: Model.getCurrentTime() ))
        fetchAll()
        
    }
    
    
    static func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: Date())
    }
    
    func fetchAll(){
        messages.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("chats")
        
        ref.getDocuments{ snapshot , error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let message = data["message"] as? String ?? ""
                    let sender = data["sender"] as? String ?? ""
                    let time = data["time"] as? String ?? ""
                    self.messages.append(Chat(
                        message: message,
                        sender: sender,
                        time: time
                        )
                    )
                }
                
                self.messages = self.messages.sorted{ $0.time < $1.time }
            }
            
        }
    }
    
    static func timestampToDate(timestamp:Timestamp) -> Date{
        let seconds = TimeInterval(timestamp.seconds)
        let nanoseconds = TimeInterval(timestamp.nanoseconds) / 1_000_000_000

        // Create a TimeInterval value by combining seconds and nanoseconds
        let timestampInterval = seconds + nanoseconds

        // Create a Date object from the TimeInterval
        let date = Date(timeIntervalSince1970: timestampInterval)
        
        return date
    }
    
    func addMessage(chat:Chat){
        messages.append(chat)
    }
    
    func submitMessage(){
        if messageText == ""{
            return
        }
        
        createMessage(message: messageText, sender: "Leo")
        APIManager.shared.askAI(userID: "Leo", chat: messageText){
            chat in
            self.storeMessage(chat)
            self.addMessage(chat: chat)
        }
            
        messageText = ""
        
    
    }
    
    fileprivate func storeMessage(_ chat: Chat) {
        let db = Firestore.firestore()
        let ref = db.collection("chats").document()
        
        ref.setData(["message":chat.message,"sender":chat.sender,"time": FieldValue.serverTimestamp()]){
            error in if error != nil {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    func createMessage(message:String, sender:String){
        withAnimation{
            
            let time = Model.getCurrentTime()
            let chat = Chat(message:message,sender:sender,time: time)
            
            storeMessage(chat)
            addMessage(chat: chat)
    
        }
    }

    func autoReply(message:String){
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.messages.append(Chat(message:"I am AI, what do you want to ask ? ",sender:"AI", time: Model.getCurrentTime() ))

        
        
        }
    }

}
