import Foundation

final class APIManager{
    
    static let shared = APIManager()
    static let apiURL =  "https://api-gw-chatbot-7923qjyk.an.gateway.dev"
    static let apiKey = "AIzaSyDdhMPubp8gw0GIzVnGMzG7bAWAGNuvwlM"
    
    private init(){
        
    }
    
    static func createChat(from responseDict: [String: Any]) -> Chat? {
        
        guard let data = responseDict["data"] as? [String: Any],
              let message = data["chat"] as? String,
              let sender = responseDict["user_id"] as? String else {
                  
                  print("createChat failed")
                  return nil
              }
        let time = Model.getCurrentTime()
        
        return Chat(message: message, sender: sender, time: time)
    }
    
    func askAI(userID:String, chat:String, _ completion: @escaping (Chat) -> Void) -> Void{
       
        // API endpoint URL
        guard let baseURL = URL(string: APIManager.apiURL) else {
            print("Invalid base URL")
            return
        }
        
        let path = "/ask"
        
        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponent?.path = path
        let queryItem = URLQueryItem(name: "api_key", value: APIManager.apiKey)
        urlComponent?.queryItems = [queryItem]
        
        
        guard let url = urlComponent?.url else {
            print("Invalid final URL")
            return
        }
        print("API's url: \(url)")
        
            // Request data
        let requestData: [String: Any] = [
            "user_id": userID,
            "data": [
                "chat": chat,
                "kind": "text",
                "coordinates": [0,0,0]
            ]
        ]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestData)
        
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            print("Data: \(data.description)")
            
            // Parse the response data
            if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []),
                let responseDict = responseJSON as? [String: Any] {
                
                // Process the response
                print("Response: \(responseDict)")
                
                if let chatInstance = APIManager.createChat(from: responseDict) {
                    print(chatInstance)
                    completion(chatInstance)
                    
                } else {
                    print("Unable to create Chat instance from responseDict")
                    return
                }
                
            } else {
                print("Invalid response")
                return
            }
        }
    
        task.resume()
        
        
    }
    
}
