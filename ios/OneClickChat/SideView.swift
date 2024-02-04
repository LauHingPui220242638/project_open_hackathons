import SwiftUI

struct SideView<RenderView: View>: View {
    @Binding var isShowing: Bool
    @Binding var isMoving: Bool
    var direction: Edge
    @Binding var sideMenuOffset : CGFloat
    @ViewBuilder  var content: RenderView
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                        sideMenuOffset = 0.0
                        
                        
                    }
                
                content
                    .background(
                        Color.brown
                    )
                    .frame(width: 300)
                    .offset(x: -300 + sideMenuOffset)
                    .transition(.move(edge: direction))
                    
                    
                    
                    
                    
            }
//            Text("\(sideMenuOffset)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
        
        
    }
}

