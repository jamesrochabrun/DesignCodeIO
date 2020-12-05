//
//  UpdateList.swift
//  SwiftUIDesignCodeIO
//
//  Created by james rochabrun on 11/12/20.
//

import SwiftUI

struct UpdateList: View {
    
    @ObservedObject var store = UpdateStore()
    
    func addUpdate() {
        
        store.updates.append(Update(image: "Card1", title: "Some new title", text: "some new text", date: "some date \(Date())"))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.updates) { itemList in
                    NavigationLink(destination: UpdateDetail(update: itemList)) {
                        HStack {
                            Image(itemList.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            
                            VStack (alignment: .leading, spacing: 8.0) {
                                
                                Text(itemList.title)
                                    .font(.system(size: 20, weight: .bold))
                                
                                Text(itemList.text)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                
                                Text(itemList.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete {
                    store.updates.remove(at: $0.first!)
                }
                .onMove { source, destination in
            
                    store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(leading: Button(action: addUpdate) {
                Text("Add update")
            }, trailing: EditButton())
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}


// MARK:- Models

struct Update: Identifiable {
    
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updateData = [
    Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),
    Update(image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "OCT 17"),
    Update(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and Web.", date: "AUG 27"),
    Update(image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in Xcode 11", date: "JUNE 26"),
    Update(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with the Framer X code editor", date: "JUN 11")
]
