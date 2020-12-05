//
//  RingView.swift
//  SwiftUIDesignCodeIO
//
//  Created by james rochabrun on 11/16/20.
//

import SwiftUI

struct RingView: View {
    
    var colorOne = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var colorTwo = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    var size: CGSize = .init(width: 300, height: 300)
    var percent: CGFloat = 50
    var multiplier: CGFloat { size.width / 44 }
    var progress: CGFloat { 1 - percent / 100 }
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: size.width, height: size.height)
            
            Circle()
                .trim(from: show ? progress : 1, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(colorOne), Color(colorTwo)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0.0))
                .frame(width: size.width, height: size.height)
                .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
                .onTapGesture {
                    show.toggle()
                }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}


/**
 Important! Animations:
 Animation modifiers declared in the children will take priority over the ones applied to a container.
 */
