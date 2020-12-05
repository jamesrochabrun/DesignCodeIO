//
//  CourseDetail.swift
//  SwiftUIDesignCodeIO
//
//  Created by james rochabrun on 11/27/20.
//

import SwiftUI

struct CourseDetail: View {
    
    var course: Course
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    
    var body: some View {
        ScrollView {
            VStack {
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
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                show = false
                                active = false
                                activeIndex = -1
                            }
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
                
                VStack(alignment: .leading, spacing: 30.0) {
                    Text("contact customer service at (877) 477-3527.")
                    Text("About")
                        .font(.title).bold()
                    Text("Payment Authorization: $139.05 This may include an additional amount to account for potential charges to your order. The final charge will match the items delivered. Orders that include alcohol require an adult signature and may require proof of age on pickup For questions about your Whole Foods Market order, contact customer service at (877) 477-3527. Payment Authorization: $139.05 This may include an additional amount to account for potential charges to your order. The final charge will match the items delivered. Orders that include alcohol require an adult signature and may require proof of age on pickup For questions about your Whole Foods Market order, contact customer service at (877) 477-3527. Payment Authorization: $139.05 This may include an additional amount to account for potential charges to your order. The final charge will match the items delivered. Orders that include alcohol require an adult signature and may require proof of age on pickup For questions about your Whole Foods Market order, contact customer service at (877) 477-3527.")
                    Text("Payment Authorization: $139.05 This may include an additional amount to account for potential charges to your order. The final charge will match the items delivered. Orders that include alcohol require an adult signature and may require proof of age on pickup For questions about your Whole Foods Market order, contact customer service at (877) 477-3527. Payment Authorization: $139.05 This may include an additional amount to account for potential charges to your order. The final charge will match the items delivered. Orders that include alcohol require an adult signature and may require proof of age on pickup For questions about your Whole Foods Market order, contact customer service at (877) 477-3527.")
                }
                .padding(30)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(course: courseData.first!, show: .constant(true), active: .constant(true), activeIndex: .constant(-1))
    }
}
