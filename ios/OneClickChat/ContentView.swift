//
//  ContentView.swift
//  EventChat
//
//  Created by Lau on 26/12/2023.
//

import SwiftUI
import FirebaseAnalyticsSwift
import Combine






struct ContentView: View {
    
    @StateObject var model = Model()
    @StateObject var authViewModel = AuthenticationViewModel()
    @State var isShowing = true
    @State var isMoving = true
    @State var sideMenuOffset:CGFloat = 300.0
    @State private var timer: AnyCancellable?
    
    var Pages:[AnyView] = [
        AnyView(Container{FirstPage()}),
        AnyView(Container{SecondPage()}),
    ]
    
    @ViewBuilder
    private func SideMenu() -> some View {
            
        SideView(isShowing: $isShowing,isMoving: $isMoving, direction:.leading , sideMenuOffset: $sideMenuOffset) {
            LoginView()
                .environmentObject(model)
                .environmentObject(authViewModel)
                
            }
        
        
    }
    
    
    func incrementOffset( value: Int = 1) {
        timer = Timer.publish(every: 0.00001, on: .main, in: .common)
                    .autoconnect()
                    .prefix(while:{_ in sideMenuOffset<=300 && isShowing && !isMoving })
                    .sink { _ in
                        sideMenuOffset += (300 - sideMenuOffset)*0.1
                        if sideMenuOffset > 300{
                            sideMenuOffset = min(sideMenuOffset,300)
                            stopIncrementing()
                        }
                    }
                    
        
        }
    func stopIncrementing() {
            timer?.cancel()
            timer = nil
        }
    

    fileprivate func Main() -> some View {
        return VStack{
            
            Spacer(minLength: 20)
            Text("One Click Chat \(model.userName ?? "")")
                .foregroundColor(.blue.opacity(0.5))
                .font(.largeTitle)
                .bold()
                .shadow(color: .gray, radius: 15, x: 0, y: 10)
            TabView{
                ForEach(0..<Pages.count){
                    i in Pages[i]
                        
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .environmentObject(model)
            
            //        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .background(.green)
        .disabled(!authViewModel.logged)
        .analyticsScreen(name: "\(ContentView.self)")
    }
    
    var body: some View {
        
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            Main()
            SideMenu()
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.startLocation.x < CGFloat(25.0)
                    && gesture.translation.width >= 0 
                    {
                        isShowing = true
                        if sideMenuOffset <= 300 {
                            sideMenuOffset = gesture.translation.width
                        }
                    }
                    
                    if gesture.translation.width < 0 && isShowing{
                        if sideMenuOffset <= 300 {
                            sideMenuOffset = 300 + gesture.translation.width
                        }
                    }
                    
                    isMoving = true

                    
                }
                .onEnded { gesture in
                    if sideMenuOffset <= 150 {
                        sideMenuOffset = 0
                        isShowing = false
                        
                    }else{
                        incrementOffset()
                        isShowing = true
                        
                    }
                    
                    if sideMenuOffset > 300{
                        sideMenuOffset = min(sideMenuOffset,300)
                        stopIncrementing()
                    }
                    
                    isMoving = false
                    
                }
                
        )
            
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
