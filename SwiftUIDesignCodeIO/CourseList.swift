//
//  CourseList.swift
//  SwiftUIDesignCodeIO
//
//  Created by james rochabrun on 11/16/20.
//

import SwiftUI

// If your padding is not working check if a view like a Image is not resized properly
// if you want to toggle the visibility of oe view from another you can use a Zstack is like adding a view on top of it as UIKit
// if you want to layout a button image insets you can embed it in a VStack

/// Geeometry reader may need to have the same size of the view that holds to be centered in screen

let cardWidthPadding: CGFloat = 60

struct CourseList: View {

    @State var courses = courseData
    @State var active = false
    @State var activeIndex = -1 // means nothing
    @State var activeView: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.black.opacity(Double(activeView.height / 500))
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    ForEach(courses.indices, id: \.self) { index in
                        let show = courses[index].show
                        GeometryReader {
                            CourseView(show: $courses[index].show,
                                       course: courses[index],
                                       active: $active,
                                       index: index,
                                       activeIndex: $activeIndex, activeView: $activeView)
                                .offset(y: show ? -$0.frame(in: .global).minY : 0)
                                .opacity(activeIndex != index && active ? 0 : 1)
                                .scaleEffect(activeIndex != index && active ? 0.5 : 1)
                                .offset(x: activeIndex != index && active ? screen.width : 0)
                            /// AMAZING 🧡
                        }
                        .frame(height: 280) // avoids the pushing of cards
                        .frame(maxWidth: show ? .infinity : screen.width - cardWidthPadding)
                        .zIndex(show ? 1 : 0)
                    } // transition with scroll - video 8 - min 03:06
                }
                .frame(width: screen.width) /// always add a frame to the child of a scrollview
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active)
            .animation(.linear)
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    
    @Binding var show: Bool
    var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("contact customer service at (877) 477-3527.")
                Text("About")
                    .font(.title).bold()
                Text("Payment Authorization: $139.05 This may include an additional amount to account for potential charges to your order. The final charge will match the items delivered. Orders that include alcohol require an adult signature and may require proof of age on pickup For questions about your Whole Foods Market order, contact customer service at (877) 477-3527. Payment Authorization: $139.05 This may include an additional amount to account for potential charges to your order. The final charge will match the items delivered. Orders that include alcohol require an adult signature and may require proof of age on pickup For questions about your Whole Foods Market order, contact customer service at (877) 477-3527. Payment Authorization: $139.05 This may include an additional amount to account for potential charges to your order. The final charge will match the items delivered. Orders that include alcohol require an adult signature and may require proof of age on pickup For questions about your Whole Foods Market order, contact customer service at (877) 477-3527.")
                Text("Payment Authorization: $139.05 This may include an additional amount to account for potential charges to your order. The final charge will match the items delivered. Orders that include alcohol require an adult signature and may require proof of age on pickup For questions about your Whole Foods Market order, contact customer service at (877) 477-3527. Payment Authorization: $139.05 This may include an additional amount to account for potential charges to your order. The final charge will match the items delivered. Orders that include alcohol require an adult signature and may require proof of age on pickup For questions about your Whole Foods Market order, contact customer service at (877) 477-3527.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0) // alpha
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                        Text(course.subtitle)
                    }
                    Spacer()
                    /// HERE how to toggle between 2 views using a ZStack
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
                }
                Spacer()
                Image(uiImage: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
    //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280) <- bad
            .frame(maxWidth: show ? .infinity : screen.width - cardWidthPadding, maxHeight: show ? 460 : 280) // <- 😍
            
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .gesture(
                show ? // enabling/disabling gestures !!!!
                DragGesture().onChanged {
                    guard $0.translation.height < 300 else { return } /// dragging down
                    guard $0.translation.height > 0 else { return } /// dragging up

                    activeView = $0.translation
                }
                .onEnded { _ in
                    if activeView.height > 50 {
                        show = false
                        active = false
                        activeIndex = -1
                    }
                    activeView = .zero
                }
                : nil
            )
            .onTapGesture {
                show.toggle()
                active.toggle()
                activeIndex = show ? index : -1
            }
            if show {
                /// Example for creating a new view like a detail one.
//                CourseDetail(course: course, show: $show, active: $active, activeIndex: $activeIndex)
//                    .background(Color.white)
//                    .animation(nil) // disable animation
            }
        }
        .frame(height: show ? screen.height : 280) // avoids the pushing of cards
        .scaleEffect(1 - activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))
        .hueRotation(Angle(degrees: Double(activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
            show ? // enabling/disabling gestures !!!!
            DragGesture().onChanged {
                guard $0.translation.height < 300 else { return } /// dragging down
                guard $0.translation.height > 0 else { return } /// dragging up

                activeView = $0.translation
            }
            .onEnded { _ in
                if activeView.height > 50 {
                    show = false
                    active = false
                    activeIndex = -1
                }
                activeView = .zero
            }
            : nil
        )
        .edgesIgnoringSafeArea(.all)
        
    }
}


struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: UIImage
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
   Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
   Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card3"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
   Course(title: "UI Design for Developers", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]
