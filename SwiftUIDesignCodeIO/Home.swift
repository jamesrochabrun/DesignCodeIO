//
//  Home.swift
//  SwiftUIDesignCodeIO
//
//  Created by james rochabrun on 11/12/20.
//

import SwiftUI

/// Buttons always tints the images or text to system blue, you need `.renderingMode(.original)` to avoid that.

/// to layout things in a screen you can use a Zstack and each layer will respect its own spaceing system, check for spacers inside views to understand layout hierarchies.

/// maybe do this `.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/) /` for each view non just the ZStack

/// If some animation is not working re arrange your view modifieres.
/// offset modifier should go first over rotation or scale effects.

/*
 drag a view steps:

/// 1 - you create a state with a CGSize
/// 2 - drag gesture and pass the translation to that size.
/// 3 - add an offset modifier to the view that you want to translate and pass the state to the offset. y for vertical x for horizontal.

 */

/// Angle(degrees: showProfile ? Double(viewState.height) - 10 , change the 10  to 0 to see the difference
/// Binding makes the data binding :P

/// Always use V or H stacks with spacers to push content to a desired location

struct Home: View {
    
    @State var showProfile = false
    @State var viewState: CGSize = .zero
    @State var showContent = false
    
    var body: some View {
        ZStack {
            // Root layer
            Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/) /// no safe area
            
            HomeView(showProfile: $showProfile, showContent: $showContent)
                .padding(.top, 44) // the VStack padding
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("background2"), Color.white]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        Spacer()
                    }
                    .background(Color.white)
                ) // the VStack background
                .clipShape(RoundedRectangle(cornerRadius: 30, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0)) // play with this to understand
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : UIScreen.main.bounds.height) // 1000 pushes 1000 Y origin
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture().onChanged {
                        self.viewState = $0.translation
                    }
                    .onEnded { _ in
                        if self.viewState.height > 50 {
                            self.showProfile = false
                        }
                        self.viewState = .zero
                    }
                )
            
            if showContent {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    ContentView()
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .offset(x: -16, y: 16)
                    .transition(.move(edge: .top))
                    /// transitions will only workk if there is not a background or any element that hides the animation
                    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                    .onTapGesture {
                        showContent = false
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvatarViewButton: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: {
            self.showProfile.toggle()
        }) {
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}

let screen = UIScreen.main.bounds
