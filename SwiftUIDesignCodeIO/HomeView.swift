//
//  HomeView.swift
//  SwiftUIDesignCodeIO
//
//  Created by james rochabrun on 11/12/20.
//

import SwiftUI


/// Swift UI aways takes the minimum isze aligns everything to the larger view.\
/// Geometry reader is a proxy that contains info about a certain view.
/// Adding padding to a view or stack defines its global space
/// control + option + click on top of the view shows the inspector.
/// offsets and spacers does the layout job.

struct HomeView: View {
    
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    
    /// Investigate what kind of properties we can store un a `View`
    /// 30 is the padding or minX of the first section view.
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                // title header
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                    Spacer()
                    AvatarViewButton(showProfile: $showProfile)
                    Button(action: {
                        self.showUpdate.toggle()
                    }) {
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                    }
                    ///  Modal presentation
                    .sheet(isPresented: $showUpdate, content: {
                        UpdateList()
                    })
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators: false){
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture{
                            showContent = true
                        }
                }
                
                // SCROLL VIEW WORK HERE!!!
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack (spacing: 20) {  /// THIS DEFINES THE LAYOUT, AND MAKES IT SCROLABLE HORIZONTALLY
                        ForEach(sectionData) { item in
                            GeometryReader { geo in
                                /// change -20 to 20 to change where the cards are facing.
                                /// -30 will make the first card dont start angled, 30 is the
                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees: Double(geo.frame(in: .global).minX - 30) / -20), axis: (x: 0, y: 10, z: 0))
                                    .onTapGesture {
                                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                                        
                                    }
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30) /// to allow the shadow of the section view show up
                }
                .offset(y: -30)
                
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(section: sectionData[2], size: .init(width: screen.width - 60, height: 375))
                    .offset(y: -60)
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    
    var section: Section
    var size: CGSize = .init(width: 275, height: 275)
    
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            
            Text(section.subTitle.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: size.width, height: size.height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

/// MARK- Models
struct Section: Identifiable {
    
    var id = UUID()
    var title: String
    var subTitle: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [Section(title: "Prototype designs in Swift UI", subTitle: "18 sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
                   Section(title: "Build a Swift UI app", subTitle: "18 sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
                   Section(title: "Prototype designs in Swift UI", subTitle: "18 sections", logo: "Logo1", image: Image("Card1"), color: Color("card1"))]

struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30.0) {
            HStack(spacing: 12.0) {
                RingView(colorOne: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), colorTwo: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), size: .init(width: 44, height: 44), percent: 68, show: .constant(true))
                VStack(spacing: 4.0) {
                    Text("4 minutes left")
                        .fontWeight(.bold)
                        .modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 min today")
                        .modifier(FontModifier(style: .caption))
                }
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(colorOne: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), colorTwo: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), size: .init(width: 32, height: 32), percent: 54, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(colorOne: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), colorTwo: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), size: .init(width: 32, height: 32), percent: 54, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
